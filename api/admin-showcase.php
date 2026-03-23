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
    // Allow action via GET for bulk uploads where body is an array
    $action = $_GET['action'] ?? '';
    if (!$action && isset($data['action'])) {
        $action = $data['action'];
    }
    if (!$action) $action = 'create';

    try {
        // Fetch valid category IDs to prevent foreign key constraint violations globally
        $validCategoriesStmt = $db->query("SELECT id FROM showcase_categories");
        $validCategoryIds = $validCategoriesStmt->fetchAll(PDO::FETCH_COLUMN);

        if ($action === 'bulk_create') {
            if (!is_array($data)) {
                throw new Exception("Invalid payload: expected an array of items.");
            }

            $db->beginTransaction();
            $stmt = $db->prepare("INSERT INTO showcase_items (title, category_id, prompt, description, type, output_url, model_used) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $count = 0;
            
            foreach ($data as $item) {
                if (empty($item['prompt']) || empty($item['output_url'])) continue;
                
                $title = $item['title'] ?? 'Imported Item';
                $categoryId = !empty($item['category_id']) ? (int) $item['category_id'] : null;
                
                // Validate foreign key constraint
                if ($categoryId !== null && !in_array($categoryId, $validCategoryIds)) {
                    $categoryId = null; // Fallback gracefully if category doesn't exist in destination DB
                }

                $prompt = $item['prompt'] ?? '';
                $description = $item['description'] ?? '';
                $type = $item['type'] ?? 'text_to_image';
                $outputUrl = $item['output_url'] ?? '';
                $modelUsed = $item['model_used'] ?? 'imported';

                $stmt->execute([$title, $categoryId, $prompt, $description, $type, $outputUrl, $modelUsed]);
                $count++;
            }
            
            $db->commit();
            echo json_encode(['success' => true, 'count' => $count]);
            exit;
        }

        $title = $data['title'] ?? '';
        $categoryId = !empty($data['category_id']) ? (int) $data['category_id'] : null;
        if ($categoryId !== null && !in_array($categoryId, $validCategoryIds)) {
            $categoryId = null; // Fallback gracefully
        }
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
        if ($db->inTransaction()) {
            $db->rollBack();
        }
        http_response_code(500);
        echo json_encode(['error' => 'Operation failed: ' . $e->getMessage()]);
    }
}
