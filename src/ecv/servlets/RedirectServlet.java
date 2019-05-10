package ecv.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import com.sun.jersey.api.client.WebResource;


import org.apache.shiro.SecurityUtils;
import org.json.JSONObject;

@WebServlet("/RedirectServlet")
public class RedirectServlet extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
		String email = currentUser.getPrincipal().toString();
		String code = req.getParameter("code");
		System.out.print(code);
		getOrcidData(code);
		getServletContext().getRequestDispatcher("/RedirectView.jsp").forward(req, resp);
	}
	
	@POST
	@Consumes("application/json")
	private void getOrcidData(String code) {
		Client client = ClientBuilder.newClient();
		WebTarget wt = client.target("https://orcid.org/oauth/token")
				.queryParam("client_id", "APP-YLLEF2IRUXC0CCFJ")
				.queryParam("client_secret", "2c2e77f3-82f4-4811-a882-cb327bde687e")
				.queryParam("grant_type", "authorization_code")
				.queryParam("code", code)
				.queryParam("redirect_uri", "localhost:8080/eCV/RedirectServlet");
		wt.request().post(Entity.entity("{}", MediaType.APPLICATION_JSON));
		System.out.println("---------llega aqui--------");
		/*JSONObject idObj = new JSONObject(userId);
		String orcidId = idObj.getString("orcid");
		System.out.println(orcidId);
		*/
	
	}
}
