<?php
/**
 * Categories API
 * GET: List all categories
 * POST/PUT/DELETE: Admin CRUD for categories
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$method = $_SERVER['REQUEST_METHOD'];
$db = getDB();

if ($method === 'GET') {
    $stmt = $db->query("SELECT * FROM showcase_categories ORDER BY name ASC");
    echo json_encode(['success' => true, 'categories' => $stmt->fetchAll()]);
    exit;
}

// Admin only for other methods
$user = authenticateRequest();
if (!(int) $user['is_admin']) {
    http_response_code(403);
    echo json_encode(['error' => 'Admin access required']);
    exit;
}

if ($method === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $action = $data['action'] ?? 'create';

    try {
        if ($action === 'create') {
            $stmt = $db->prepare("INSERT INTO showcase_categories (name, slug, description) VALUES (?, ?, ?)");
            $stmt->execute([$data['name'], $data['slug'], $data['description'] ?? '']);
            echo json_encode(['success' => true, 'id' => $db->lastInsertId()]);
        } elseif ($action === 'update') {
            $stmt = $db->prepare("UPDATE showcase_categories SET name=?, slug=?, description=? WHERE id=?");
            $stmt->execute([$data['name'], $data['slug'], $data['description'] ?? '', $data['id']]);
            echo json_encode(['success' => true]);
        } elseif ($action === 'delete') {
            $stmt = $db->prepare("DELETE FROM showcase_categories WHERE id = ?");
            $stmt->execute([$data['id']]);
            echo json_encode(['success' => true]);
        }
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}
