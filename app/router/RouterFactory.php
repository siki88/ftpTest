<?php

namespace App;

use Nette;
use Nette\Application\Routers\Route;
use Nette\Application\Routers\RouteList;


final class RouterFactory
{
	use Nette\StaticClass;

	/**
	 * @return Nette\Application\IRouter
	 */
	public static function createRouter()
	{

		$router = new RouteList;
		$router[] = new Route('<presenter>/<action>[/<id>]', 'Homepage:default');
		return $router;


/*
        $router = new RouteList;
        $router[] = $module = new RouteList('Admin');
        $module[] = new Route('admin/<presenter>/<action>', 'Admin:default');

        $router[] = $module = new RouteList('Front');
    //    $router[] = new Route('index.php', 'Front:Default:default', Route::ONE_WAY);
        $module[] = new Route('<presenter>/<action>', 'Homepage:default');
        return $router;
*/
/*
        $router = new RouteList;
        $router[] = $module = new RouteList('Admin');
        $module[] = new Route('admin/<presenter>/<action>', ['module' => 'Admin']);

        $router[] = $module = new RouteList('Front');
        //    $router[] = new Route('index.php', 'Front:Default:default', Route::ONE_WAY);
        $module[] = new Route('<presenter>/<action>', 'Homepage:default');

        return $router;
*/
	}
}
