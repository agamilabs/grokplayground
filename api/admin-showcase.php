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
        if ($action === 'create') {
            $stmt = $db->prepare("INSERT INTO showcase_items (category_id, title, prompt, description, type, model_used, settings_json, output_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([
                $data['category_id'] ?? null,
                $data['title'],
                $data['prompt'],
                $data['description'] ?? '',
                $data['type'],
                $data['model'] ?? 'grok-imagine-image',
                json_encode($data['settings'] ?? []),
                $data['output_url']
            ]);
            echo json_encode(['success' => true, 'id' => $db->lastInsertId()]);

        } elseif ($action === 'update') {
            $id = (int) $data['id'];
            $stmt = $db->prepare("UPDATE showcase_items SET category_id=?, title=?, prompt=?, description=?, type=?, model_used=?, settings_json=?, output_url=? WHERE id=?");
            $stmt->execute([
                $data['category_id'] ?? null,
                $data['title'],
                $data['prompt'],
                $data['description'] ?? '',
                $data['type'],
                $data['model'] ?? 'grok-imagine-image',
                json_encode($data['settings'] ?? []),
                $data['output_url'],
                $id
            ]);
            echo json_encode(['success' => true]);

        } elseif ($action === 'delete') {
            $id = (int) $data['id'];
            $stmt = $db->prepare("DELETE FROM showcase_items WHERE id = ?");
            $stmt->execute([$id]);
            echo json_encode(['success' => true]);
        }
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Operation failed: ' . $e->getMessage()]);
    }
}
