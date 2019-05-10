<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>StudiesView</title>
	<style type="text/css">
		<%@ include file="css/studiesView.css" %>
	</style>
</head>
<body>
	<shiro:lacksRole name="usuario">
	No tienes permiso para ver el contenido de esta página
	</shiro:lacksRole>
	<shiro:hasRole name="usuario">
	
			<div class="mainDiv">
			
				<div class="header">
					<div class="headerContent">
						
						<div class="logoDiv">
							<img id="logo" src="img/logo.png">
							<h1>eCV</h1>
						</div>
							
						<form action="PDFServlet" method="get">
							<input type="hidden" name="email" value="${usuario.email}"/>
							<button class="exportBttn" type="submit" formtarget="_blank">Exportar PDF</button>
						</form>
						
						<form action="CVServlet" method="get">
							<input type="hidden" name="email" value="${usuario.email}"/>
							<button class="exportBttn" type="submit">Mis CV</button>
						</form>
						
						<div class="bttns">
							<h6>¡Bienvenido/a, ${usuario.pd.name}!</h6>
							<form action="LogoutServlet" method="get"><button class="headerButton" type="submit">Logout</button></form>	
						</div>					
					</div>
				</div>
				
				<div class="userViewDiv">
					<div class="navigationBar">
						<div class="navigationBarContent">
							<h2 class="pageName">Mis Datos</h2>
								<div class="botonera">
								
								
								<form action="ToUserServlet" method="post">
									<input type="hidden" name="email" value="${usuario.email}" />
									<button class="menuButton" type="submit">Datos Personales</button>
								</form>
								
								<form action="ToCareerServlet" method="post">
									<input type="hidden" name="email" value="${usuario.email}" />
									<button class="menuButton" type="submit">Datos Profesionales</button>
								</form>
								
								<button class="menuButton" type="submit" disabled>Datos Académicos</button>
								
							</div>
						</div>
					</div>
					<div>
						<h7>Información académica</h7>
						<div class="dataSection">
							<h3>Titulaciones</h3>
								<table border="1">
									<tr>
										<td>Nombre de la titulación</td>
										<td>Entidad de titulación</td>
										<td>Fecha de titulación</td>
										<td>Borrar</td>
									</tr>
									<tr>
										<c:forEach items="${usuario.studies.degrees}" var="degreei">
											<tr>
												<td>${degreei.name}</td>
												<td>${degreei.place}</td>
												<td>${degreei.date}</td>
												<td><form action="RemoveDegreeServlet" method="post">
													<input type="hidden" name="email" value="${usuario.email}" />
													<input type="hidden" name="degreeId" value="${degreei.id}">
													<button class="removeButton" type="submit">Borrar</button>
												</form></td>
											</tr>
										</c:forEach>
									</tr>
								</table>
								<h5>Modificar datos:</h5>
								
								<div><form action="AddDegreeServlet" method="post">
									<input type="hidden" name="email" value="${usuario.email}" />
									<input type="hidden" name="studiesId" value="${usuario.studies.id}" />
									<input type="text" name="name" placeholder="Nombre de la titulación" required />
									<input type="text" name="ent" placeholder="Entidad de la titulación" required />
									<input type="text" name="day" placeholder="dd" maxlength="2" required />
									<input type="text" name="month" placeholder="mm" maxlength="2" required />
									<input type="text" name="year" placeholder="aaaa" maxlength="4" required />
								<button class="saveButton" type="submit">Guardar</button>
								<c:if test="${errorTag == 1}">
									<br><span class="errorText">La fecha introducida es errónea</span>
								</c:if>			
								</form>								
								</div>
								
								<h3>Doctorados</h3>
								<table border="1">
									<tr>
										<td>Nombre de la titulación</td>
										<td>Entidad de titulación</td>
										<td>Fecha de titulación</td>
										<td>Borrar</td>
									</tr>
									<tr>
										<c:forEach items="${usuario.studies.phds}" var="phdi">
											<tr>
												<td>${phdi.name}</td>
												<td>${phdi.place}</td>
												<td>${phdi.date}</td>
												<td><form action="RemovePhdServlet" method="post">
													<input type="hidden" name="email" value="${usuario.email}" />
													<input type="hidden" name="phdId" value="${phdi.id}">
													<button class="removeButton" type="submit">Borrar</button>
												</form></td>
											</tr>
										</c:forEach>
									</tr>
								</table>
								<h5>Modificar datos:</h5>
								
								<div><form action="AddPhdServlet" method="post">
									<input type="hidden" name="email" value="${usuario.email}" />
									<input type="hidden" name="studiesId" value="${usuario.studies.id}" />
									<input type="text" name="name" placeholder="Nombre de la titulación" required />
									<input type="text" name="ent" placeholder="Entidad de la titulación" required />
									<input type="text" name="day" placeholder="dd" maxlength="2" required />
									<input type="text" name="month" placeholder="mm" maxlength="2" required />
									<input type="text" name="year" placeholder="aaaa" maxlength="4" required />
								<button class="saveButton" type="submit">Guardar</button>
								<c:if test="${errorTag == 3}">
									<br><span class="errorText">La fecha introducida es errónea</span>
								</c:if>
								</form>								
								</div>
								
								<h3>Idiomas</h3>
								<table border="1">
									<tr>
										<td>Idioma</td>
										<td>Comprensión auditiva</td>
										<td>Comprensión lectora</td>
										<td>Interacción oral</td>
										<td>Borrar</td>
									</tr>
									<tr>
										<c:forEach items="${usuario.studies.languages}" var="langi">
											<tr>
												<td>${langi.name}</td>
												<td>${langi.listeningLevel}</td>
												<td>${langi.readingLevel}</td>
												<td>${langi.speakingLevel}</td>
												<td><form action="RemoveLanguageServlet" method="post">
													<input type="hidden" name="email" value="${usuario.email}" />
													<input type="hidden" name="langId" value="${langi.id}">
													<button class="removeButton" type="submit">Borrar</button>
												</form></td>
											</tr>
										</c:forEach>
									</tr>
								</table>
								<h5>Modificar datos:</h5>
								
								<div><form action="AddLanguageServlet" method="post">
									<input type="hidden" name="email" value="${usuario.email}" />
									<input type="hidden" name="studiesId" value="${usuario.studies.id}" />
									<input type="text" name="name" placeholder="Idioma" required />
									<input type="text" name="lst" placeholder="Comprensión auditiva"required  />
									<input type="text" name="rdg" placeholder="Comprensión lectora"required  />
									<input type="text" name="spk" placeholder="Interacción oral"required  />
								<button class="saveButton" type="submit">Guardar</button>
								</form>								
								</div>
								
															
						</div>
					</div>
				</div>
		
			</div>
	</shiro:hasRole>
</body>
</html>