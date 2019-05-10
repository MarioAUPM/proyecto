<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Login View</title>
	<style type="text/css">
		<%@ include file="css/loginView.css" %>
	</style>
</head>

<body>
	<shiro:guest>
		<div class="mainDiv">
			<div class="div-logo">
                	<img id="logo" src="img/logo.png"></span>
			</div>
			<div class="accessDiv">
				<h2>Iniciar sesión en su cuenta</h2>
				<form action="LoginServlet" method="post">
						
					<br><input type="text" name="email" placeholder="Dirección de correo electrónico" />
					<c:if test="${errorTag == 1}">
						<span class="errorText">*No hemos encontrado ninguna cuenta con la dirección de correo electrónico que ha introducido. Compruebe que la dirección o la contraseña sean correctas o escriba otra dirección de correo electrónico.</span>
					</c:if>
						
					<br><input type="password" name="password" placeholder="Contraseña" />
					<c:if test="${errorTag == 2}">
						<br><span class="errorText">No puede haber campos vacios</span>
					</c:if>
					<br><button class="logButton" type="submit">Iniciar sesión</button>
				</form>	
			</div>
			<div class="seccion-registro">
                <p class="text-center">¿No tiene cuenta?  <a href="RegisterView.jsp">Registrarse</a></p>       
            </div>	
		</div>
	</shiro:guest>
</body>
</html>