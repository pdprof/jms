print "Create J2C Authentication Data ..."
AdminTask.createAuthDataEntry('[-alias appAuth -user app -password passw0rd -description ]')
print "Create QCF ..."
AdminTask.createWMQConnectionFactory('"WebSphere MQ JMS Provider(cells/DefaultCell01/nodes/DefaultNode01/servers/server1|resources.xml#builtin_mqprovider)"', '[-type QCF -name QCF -jndiName QCF -description  -qmgrName QM1 -wmqTransportType CLIENT -qmgrSvrconnChannel DEV.APP.SVRCONN -qmgrHostname localhost -qmgrPortNumber 1414 -mappingAlias DefaultPrincipalMapping -containerAuthAlias DefaultNode01/appAuth]')
print "Create Q1, Q2 and Q3 ..."
AdminTask.createWMQQueue('server1(cells/DefaultCell01/nodes/DefaultNode01/servers/server1|server.xml)', '[-name Q1 -jndiName Q1 -queueName DEV.QUEUE.1 -qmgr QM1 -description ]')
AdminTask.createWMQQueue('server1(cells/DefaultCell01/nodes/DefaultNode01/servers/server1|server.xml)', '[-name Q2 -jndiName Q2 -queueName DEV.QUEUE.2 -qmgr QM1 -description ]')
AdminTask.createWMQQueue('server1(cells/DefaultCell01/nodes/DefaultNode01/servers/server1|server.xml)', '[-name Q3 -jndiName Q3 -queueName DEV.QUEUE.3 -qmgr QM1 -description ]')
print "Create AS ..."
AdminTask.createWMQActivationSpec('"WebSphere MQ JMS Provider(cells/DefaultCell01/nodes/DefaultNode01/servers/server1|resources.xml#builtin_mqprovider)"', '[-name AS -jndiName AS -description -destinationJndiName Q3 -destinationType javax.jms.Queue -messageSelector -qmgrName QM1 -wmqTransportType CLIENT -qmgrSvrconnChannel DEV.APP.SVRCONN -qmgrHostname localhost -qmgrPortNumber 1414 -authAlias DefaultNode01/appAuth ]')
print "Install jms.war ..."
AdminApp.install('/work/config/jms.war', '[ -nopreCompileJSPs -distributeApp -nouseMetaDataFromBinary -appname jms_war -createMBeansForResources -noreloadEnabled -nodeployws -validateinstall warn -noprocessEmbeddedConfig -filepermission .*\.dll=755#.*\.so=755#.*\.a=755#.*\.sl=755 -noallowDispatchRemoteInclude -noallowServiceRemoteInclude -asyncRequestDispatchType DISABLED -nouseAutoLink -noenableClientModule -clientMode isolated -novalidateSchema -contextroot /jms -MapModulesToServers [[ jms jms.war,WEB-INF/web.xml WebSphere:cell=DefaultCell01,node=DefaultNode01,server=server1 ]] -MapWebModToVH [[ jms jms.war,WEB-INF/web.xml default_host ]] -CtxRootForWebMod [[ jms jms.war,WEB-INF/web.xml /jms ]] -BindJndiForEJBMessageBinding [[ jms PdprofMdb jms.war,WEB-INF/ejb-jar.xml "" AS Q3 DefaultNode01/appAuth ]] -MapResEnvRefToRes [[ jms "" jms.war,WEB-INF/web.xml Q1 javax.jms.Queue Q1 ][ jms "" jms.war,WEB-INF/web.xml Q2 javax.jms.Queue Q2 ][ jms "" jms.war,WEB-INF/web.xml Q3 javax.jms.Queue Q3 ]]]' )
AdminConfig.save()

