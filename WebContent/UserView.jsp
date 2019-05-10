<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UserView</title>
	<style type="text/css">
		<%@ include file="css/userView.css" %>
	</style>
</head>

<script type=text/javascript>
var oauthWindow;
function openORCID() {
    var oauthWindow = window.open("https://orcid.org/oauth/authorize?client_id=APP-YLLEF2IRUXC0CCFJ&response_type=code&scope=/authenticate&redirect_uri=http://localhost:8080/eCV/RedirectServlet", "_blank", "toolbar=no, scrollbars=yes, width=500, height=600, top=500, left=500");

}
</script>

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
								<button class="menuButton" type="submit" disabled="true">Datos Personales</button>
								
								<form action="ToCareerServlet" method="post">
									<input type="hidden" name="email" value="${usuario.email}" />
									<button class="menuButton" type="submit">Datos Profesionales</button>
								</form>
								
								<form action="ToStudiesServlet" method="post">
									<input type="hidden" name="email" value="${usuario.email}" />
									<button class="menuButton" type="submit">Datos Académicos</button>
								</form>
								
							</div>
						</div>
					</div>
				
					<div>
						<h7>Datos Personales</h7>
						
						<div class="orcidDiv">
							<h6 id="llamada">Importar datos de ORCID</h6>
							<div class="inDiv">
								<button id="connect-orcid-button" onClick="openORCID()"><img id="orcid-id-icon" src="https://orcid.org/sites/default/files/images/orcid_24x24.png" width="24" height="24" alt="ORCID iD icon"/>Añade datos desde ORCID</button>
							</div>
						</div>
						
						
						<form action="UpdatePDServlet" method="post">
						
							<div class="dataSection">
								<button class="saveButton" type="submit">Guardar</button>
								<input type="hidden" name="pd" value="${usuario.pd.id}" />
								<input type="hidden" name="email" value="${usuario.email}" />
								<h3>Datos Generales</h3>
								<h5>Nombre</h5>
								<span>${usuario.pd.name} ${usuario.pd.surname}</span>
								<h5>NIF</h5>
								<span>${usuario.pd.nif}</span>
								<h5>Fecha de nacimiento</h5>
								<span>${bday}-${bmonth}-${byear}</span>
								<h5>Género</h5>
								<span>${gender}</span>
								<select name="gender">
									<option value="none" disabled selected>Género</option>
									<option value="m">Hombre</option>
									<option value="f">Mujer</option>
									<option value="o">Otro</option>
								</select>
							</div>
		
							<div class="dataSection">
								<h3>Contacto</h3>
								<h5>Teléfono fijo*</h5>
								<input type="text" name="tlf" placeholder="Teléfono fijo" value="${usuario.pd.tlf}" minlength="9" maxlength="9" required />
								<c:if test="${errorTag[1] == 1}">
									<span class="errorText">*El formato del teléfono es incorrecto.</span>
								</c:if>
								<h5>Teléfono movil*</h5>
								<input type="text" name="mobile" placeholder="Teléfono movil" value="${usuario.pd.mobile}" minlength="9" maxlength="9" required />
								<c:if test="${errorTag[2] == 1}">
									<span class="errorText">*El formato del teléfono es incorrecto.</span>
								</c:if>
								<h5>Fax(Opcional)</h5>
								<input type="text" name="fax" placeholder="Fax" value="${usuario.pd.fax}" />
								<c:if test="${errorTag[3] == 1}">
									<span class="errorText">*El formato del fax es incorrecto.</span>
								</c:if>								
								<h5>Página web(Opcional)</h5>
								<input type="text" name="web" value="${usuario.pd.web}" placeholder="Web" />
							</div>
						
							<div class="dataSection">
								<h3>Nacionalidad y Dirección</h3>
								
								<div class="addrSection">
									<h4>Dirección</h4>
									<input type="hidden" name="addrId" value="${usuario.pd.address.id}" />
									<h5>Dirección*</h5>
									<input type="text" name="aAddr" value="${usuario.pd.address.addr}" placeholder="Direccion" required />
									<h5>Ciudad*</h5>
									<input type="text" name="aCity" value="${usuario.pd.address.city}" placeholder="Ciudad" required />
									<h5>Región*</h5>
									<input type="text" name="aRegion" value="${usuario.pd.address.region}" placeholder="Region" required />
									<h5>País*</h5>
									<input type="text" name="aCountry" value="${usuario.pd.address.country}" placeholder="Pais" required />
								</div>
							
								<div class="addrSection">
									<h4>Nacionalidad</h4>
									<input type="hidden" name="nationalityId" value="${usuario.pd.nationality.id}" />
									<h5>Dirección*</h5>
									<input type="text" name="nAddr" value="${usuario.pd.nationality.addr}" placeholder="Direccion" required />
									<h5>Ciudad*</h5>
									<input type="text" name="nCity" value="${usuario.pd.nationality.addr}" placeholder="Ciudad" required />
									<h5>Región*</h5>
									<input type="text" name="nRegion" value="${usuario.pd.nationality.addr}" placeholder="Region" required />
									<h5>País*</h5>
									<input type="text" name="nCountry" value="${usuario.pd.nationality.addr}" placeholder="Pais" required />
								</div>	
								
							</div>	
							
							<div class="dataSection">
								<div class="freeTextSection">
								<h4>Más datos</h4>
									<textarea class="form-control" name="freeText" placeholder="Añadir más datos aquí. 200 caracteres máximos." rows="10" maxlength="200">${usuario.pd.textFree}</textarea>
								</div>
								<button class="saveButton" type="submit">Guardar</button>
							</div>
					</form>
						
						
					</div>
				</div>
		
			</div>
	</shiro:hasRole>
</body>
</html>
