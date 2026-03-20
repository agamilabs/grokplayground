<?php
$_GET['step'] = 'database';
ob_start();
include 'install.php';
$output = ob_get_clean();

if (strpos($output, 'Installer Password') !== false) {
    echo "UI SUCCESS: 'Installer Password' found in output.\n";
} else {
    echo "UI FAILURE: 'Installer Password' NOT found.\n";
    // echo $output; // for debugging
}
?>