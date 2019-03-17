<?php
/**
 * Created by PhpStorm.
 * User: Programovani
 * Date: 16.1.2019
 * Time: 11:12
 */

namespace App\Model;

use Nette,
     Nette\Database\Context;

class EvaluationsManager {

    use Nette\SmartObject;

    private $database;

    public function __construct(Context $database){
        $this->database = $database;
    }

    private function getPublicEvaluation(){
        return $this->database->table('evaluation');
    }

    public function getPublicEvaluationNewsId($newsId){
        return $this->getPublicEvaluation()->where('news_id', $newsId);
    }

    public function getNameColumns(){
        return $this->database->getConnection()->GetSupplementalDriver();
    }

    public function getPublicEvaluationInchNewsId($newsId){
        var_dump($newsId);
    }

    public function setPublicEvaluationDelete($evaluation_id){
        return $this->database->table('evaluation')->where('id', $evaluation_id)->delete();
    }

    public function setPublicEvaluation($news_id,$evaluation_data,$user_id){
        $generateTable = $this->generateTableEvaluation($news_id,$evaluation_data,$user_id);
        $row = $this->getPublicEvaluation()->insert($generateTable);
        return $row;
    }


    private function generateTableEvaluation($news_id,$evaluation_data,$user_id){
        $evaluationTable = [
            'news_id'  => (int)$news_id,
            'users_id' => (int)$user_id
        ];
            if($evaluation_data == 'true'){
                $evaluationTable['inch_up'] = 1;
            }elseif($evaluation_data == 'false'){
                $evaluationTable['inch_down'] = 1;
            }
        return $evaluationTable;
    }


}