<?php

namespace App\Presenters;

use Nette\Application\UI\Presenter,
     App\Model\NewsManager,
     App\Model\AuthenticatorManager,
     App\Model\UsersManager,
     App\Model\EvaluationsManager,
     App\Model\TokenManager,
     Nette\Utils\Validators,
     Nette\Application\Responses\JsonResponse;

final class ApiPresenter extends Presenter{

    private $newsManager,
             $usersManager,
             $evaluationsManager,
             $authenticatorManager,
             $tokenManager;

    public function __construct(NewsManager $newsManager, UsersManager $usersManager, EvaluationsManager $evaluationsManager, AuthenticatorManager $authenticatorManager, TokenManager $tokenManager){
        $this->newsManager = $newsManager;
        $this->usersManager = $usersManager;
        $this->evaluationsManager = $evaluationsManager;
        $this->authenticatorManager = $authenticatorManager;
        $this->tokenManager = $tokenManager;
    }


    public function renderDefault(){
    }


    public function actionDefault(){
    	                $status = [
                            'code' => 406,
                            'description' => 'Invalid post address'
                        ];  
                        $this->response($status); 
    }


    public function actionLogin(){
        //whitelist
        $securityArray = ['email','password'];
        $httpRequest = $this->getHttpRequest();        
            if($httpRequest->isMethod('POST') && array_key_exists('email', $httpRequest->getPost()) && array_key_exists('password', $httpRequest->getPost())){
                $request = array_intersect_key($httpRequest->getPost(), array_flip($securityArray));                
                    if(Validators::isEmail($request['email']) && count($request) == 2){
                        $status = $this->authenticatorManager->authenticate($request)->getData();
                    }else{                   	
                        $status = [
                            'code' => 406,
                            'description' => 'Invalid email, password format OR email, password is empty OR none exists parameter '
                        ];
                    }
                $this->response($status);
            }else{
                        $status = [
                            'code' => 406,
                            'description' => 'Invalid post format OR email or password key none exists'
                        ];  
                        $this->response($status);          	
            }
    }

    public function actionToken(){
        //whitelist
        $securityArray = ['token'];
        $httpRequest = $this->getHttpRequest();
        if($httpRequest->isMethod('POST')){
            $request = array_intersect_key($httpRequest->getPost(), array_flip($securityArray));

            // KONTROLA EXPIRACE TOKENU
            $status = $this->tokenManager->getControlExpiration($request['token']);

            if($status){
                $status = [
                    'code' => 200,
                    'description' => 'Token is ok. Expirate date is extended'
                ];
            }else{
                $status = [
                    'code' => 401,
                    'description' => 'Token has expired, login in again. OR not found'
                ];
            }
            $this->response($status);
        }
    }



    public function actionNews(){
        $data = $this->newsManager->getPublicNewsQuery();
        $this->response($data);

    }

    //zaslání hodnocení
    public function actionEvaluation(){
        //whitelist
        $securityArray = ['token','news_id','evaluation'];
        $httpRequest = $this->getHttpRequest();

        //Pole všech parametrů odeslaných aplikaci požadavkem GET => $this->request->getParameters() ;
        //Pole všech parametrů odeslaných aplikaci požadavkem POST => $this->request->getPost() ;
        //$this->controllValidation($httpRequest->getPost(), $securityArray);

        if($httpRequest->isMethod('POST')){
            $request = array_intersect_key($httpRequest->getPost(), array_flip($securityArray));
                if($request && !Validators::isList($request) && Validators::isNumericInt($request['news_id']) && !Validators::isNone($request['token'])){
                    $tokenTable = $this->tokenManager->getControlExpiration($request['token']);
                    if($tokenTable){
                        //if exists news_id
                        if($this->newsManager->getPublicNewsId($request['news_id'])){
                            if($this->evaluationsManager->setPublicEvaluation($request['news_id'],$request['evaluation'],$tokenTable->user_id)){
                                $status = [
                                    'token' => $tokenTable->token,
                                    'code' => 200,
                                    'description' => 'evaluation is save'
                                ];
                            }else{
                                $status = [
                                    'code' => 409,
                                    'description' => 'evaluation is unsaved'
                                ];
                            }
                        }else{
                            $status = [
                                'code' => 401,
                                'description' => 'News not found'
                            ];
                        }
                    }else{
                        $status = [
                            'code' => 401,
                            'description' => 'Token has expired, login in again. OR not found'
                        ];
                    }
                }else{
                    $status = [
                        'code' => 409,
                        'description' => 'Invalid parameters'
                    ];
                }
            $this->response($status);
        }
    }


/*
    //  test validatoru
    private function controllValidation($httpRequest,$securityArray){
        //whitelist
        $securityArray = [
                        'token'    => 'string:88',
                        'news_id' => 'string',
                        'evaluation' => 'string'
                         ];

        foreach($securityArray as $key => $value){
        //    var_dump($httpRequest);
        //    var_dump($key);
        //    var_dump($value);
            Validators::assertField($httpRequest, $key, $value);

                $this->response($httpRequest);

        }
        return true;
    }
*/

    private function response($data){
        $this->sendResponse(new JsonResponse($data, "application/json;charset=utf-8"));
    }


}
