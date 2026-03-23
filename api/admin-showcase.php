<?php
/**
 * Admin Showcase API
 * POST: Create, Update, or Delete showcase items
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();
if (!(int) $user['is_admin']) {
    http_response_code(403);
    echo json_encode(['error' => 'Admin access required']);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];
$db = getDB();

if ($method === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $action = $data['action'] ?? 'create';

    try {
        $title = $data['title'] ?? '';
        $categoryId = !empty($data['category_id']) ? (int) $data['category_id'] : null;
        $prompt = $data['prompt'] ?? '';
        $description = $data['description'] ?? '';
        $type = $data['type'] ?? 'text_to_image';
        $outputUrl = $data['output_url'] ?? '';

        if ($action === 'create') {
            $stmt = $db->prepare("INSERT INTO showcase_items (title, category_id, prompt, description, type, output_url) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$title, $categoryId, $prompt, $description, $type, $outputUrl]);
            echo json_encode(['success' => true, 'id' => $db->lastInsertId()]);

        } elseif ($action === 'update') {
            $id = (int) ($data['id'] ?? 0);
            $stmt = $db->prepare("UPDATE showcase_items SET title=?, category_id=?, prompt=?, description=?, type=?, output_url=? WHERE id=?");
            $stmt->execute([$title, $categoryId, $prompt, $description, $type, $outputUrl, $id]);
            echo json_encode(['success' => true]);

        } elseif ($action === 'delete') {
            $id = (int) ($data['id'] ?? 0);
            $stmt = $db->prepare("DELETE FROM showcase_items WHERE id = ?");
            $stmt->execute([$id]);
            echo json_encode(['success' => true]);
        }
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Operation failed: ' . $e->getMessage()]);
    }
}
