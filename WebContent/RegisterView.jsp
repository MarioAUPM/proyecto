<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register View</title>
	<style type="text/css">
		<%@ include file="css/registerView.css" %>
	</style>
</head>
<body>
	<shiro:guest>
		<div class="mainDiv">
			<div class="header">
				<!-- AQUI HAY QUE PONER LA IMAGEN DE LA EMPRESA EN UN <image src=""> -->
				<h1>eCV</h1>
			</div>
			<div class="accessDiv">
					<form action="CreateUsuarioServlet" method="post">
						<h3 class="sectionName">Nombre de usuario</h3>
						<br><input type="text" name="name" placeholder="Nombre" required />
						<h3 class="sectionName">Apellidos</h3>
						<br><input type="text" name="sname" placeholder="Apellidos" required />
						<h3 class="sectionName">Nif</h3>
						<br><input type="text" name="nif" placeholder="Nif" required />
						<h3 class="sectionName">Fecha de nacimiento</h3>
						<br><input type="text" name="bday" placeholder="dd" maxlength="2" required />
						<input type="text" name="bmonth" placeholder="mm" maxlength="2" required />
						<input type="text" name="byear" placeholder="aaaa" maxlength="4" required />
						<c:if test="${errorTag == 4}">
							<br><span class="errorText">La fecha introducida es errónea</span>
						</c:if>
						<h3 class="sectionName">Email</h3>
						<br><input type="text" name="email" placeholder="Email" required />
						<c:if test="${errorTag == 1}">
							<span class="errorText">Existe otra cuenta asociada a este email</span>
						</c:if>
						<h3 class="sectionName">Contraseña</h3> 
						<br><input type="password" name="password" placeholder="Password" required />
						<h3 class="sectionName">Repita la contraseña</h3> 
						<br><input type="password" name="password2" placeholder="Repita la contraseña" required />
						<c:if test="${errorTag == 3}">
							<br><span class="errorText">Las contraseñas no coinciden</span>
						</c:if>
						<br><button class="logButton" type="submit">Registrarse</button>
					</form>
					<form action="ReturnToMainServlet" method="post"><button class="backButton" type="submit">Volver</button></form>
			</div>
		</div>
	</shiro:guest>
</body>
</html>