<?php
$cn = sqlsrv_connect('test', ['Database'=>'abc', 'LoginTimeout'=>1]);
if (empty(sqlsrv_errors()[1])) {
    die(1);
}
