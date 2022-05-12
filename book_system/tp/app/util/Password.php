<?php
namespace app\util;
class Password{
    public static function md5($code){
        return md5(md5($code).md5('lala'));
    }
}
?>