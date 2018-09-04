# Presentation
Simple BASH CLI for docker administration.

# Usage
<code>docker-admin COMMAND </code>

Commands:

	* harbor		Harbor's registry management

	get-images : print images details		

	get-image-package-vulnerability-fixed: print informations about update available for vulnerable package		

	get-image-tags : print images tags details		

	get-projects : print project's details		

	get-user-info : print user info. without arg for configured user or with arg for a different user 'get-user-info user'

	image		Mange images

	p|prune : Remove unused images 		
	l|pull : Pull an image or a repository from a registry 		
	s|push : Push an image or a repository to a registry

	install		Install docker-admin in PATH, monitoring, ...

	compose|docker-compose : Install docker-compose 		

	monitoring : Install monitoring tools for docker. Base on https://github.com/stefanprodan/dockprom                 

	path : Install docker-admin in your PATH

	list		List all available container

	compose|docker-compose : Install docker-compose 		

	monitoring : Install monitoring tools for docker. Base on https://github.com/stefanprodan/dockprom                 

	path : Install docker-admin in your PATH

	uninstall	Uninstall docker-admin in PATH, monitoring, ...

	compose|docker-compose : Install docker-compose 		

	monitoring : Install monitoring tools for docker. Base on https://github.com/stefanprodan/dockprom                 

	path : Install docker-admin in your PATH

	volume		Manage volumes

	c|create : Create a volume 		
	i|inspect : Display detailed information on one or more volumes 		
	p|prune : Remove unused volumes 		
	r|rm : Remove one or more volumes
