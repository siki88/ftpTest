user.name: admin@example.com
password:  admin


API:
##.../api/news
VSTUP:
       /
VYSTUP:        
####vypíše všechny novinky


##.../api/login
VSTUP: POST :
    email : admin@example.com
    password : admin
VYSTUP:
    email :
    token :            
    code  :
    description :
####zkontroluje zda existuje uživatel, zda heslo souhlasí. Zda existuje token uživatele, pokud ne- vytvoří. Pokud ano, a je po expiraci - vytvoří nový, v opačném případě pouze prodlouží expiraci

##.../api/token
VSTUP: POST :
    token : 
VYSTUP:          
    code  :
    description :     
####zkontroluje zda existuje token a zda je či není po expiraci, pokud je po expiraci doporučuji provést odhlášení z aplikace   

##.../api/evaluation
VSTUP: POST :
    token : 
    news_id :
    evaluation :
VYSTUP:          
    code  :
    description :  
###zkontroluje zda existuje token, a expiraci, pokud vše vpořádku zapiše hodnocení k článku    