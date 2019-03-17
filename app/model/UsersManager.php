<?php
/**
 * Created by PhpStorm.
 * User: Programovani
 * Date: 16.1.2019
 * Time: 11:12
 */

namespace App\Model;

use Nette,
     Nette\Database\Context,
     Nette\Security\Passwords;

class UsersManager {

    use Nette\SmartObject;

    private $database;

    public function __construct(Context $database){
        $this->database = $database;
    }

    public function getPublicUsers(){
        return $this->database->table('users');
    }

    public function getNameColumns(){
        return $this->database->getConnection()->GetSupplementalDriver();
    }

    public function setAddUser($values){
        $values->password = Passwords::hash($values->password);
        $this->database->table('users')->insert($values);
    }

    public function getPublicUsersRole(){
        return $this->getPublicUsers()->select('users.* , :roles.name')->joinWhere(':roles', 'users.roles_id = :roles.id');

        /*
        return $this->database->table('news')
            ->select('news.*, SUM(:evaluation.inch_up) AS inch_up , SUM(:evaluation.inch_down) AS inch_down')
            ->joinWhere(':evaluation',':evaluation.news_id = news.id')
            ->group('news.id');
        */
    }



}