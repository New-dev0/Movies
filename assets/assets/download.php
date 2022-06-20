<?php

if (!file_exists('madeline.php')) {
    copy('https://phar.madelineproto.xyz/madeline.php', 'madeline.php');
}
include 'madeline.php';

$MadelineProto = new \danog\MadelineProto\API('session.madeline');
yield $MadelineProto->downloadToBrowser('CAADAQADFgEAAhCVOEen4AJ2oDfl8gI');

>