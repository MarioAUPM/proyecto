package ecv.servlets;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ecv.dao.CareerDAO;
import ecv.dao.CareerDAOImplementation;
import ecv.dao.CurrentJobDAO;
import ecv.dao.CurrentJobDAOImplementation;
import ecv.dao.UsuarioDAO;
import ecv.dao.UsuarioDAOImplementation;
import ecv.model.Career;
import ecv.model.CurrentJob;
import ecv.model.Usuario;

//CUANDO SE QUIERA AÑADIR LA PÁGINA PRINCIPAL EN LA DEFINICION DE ESTE WEBSERVLET SE TIENE QUE QUITAR LA PARTE DE "/"
@WebServlet("/UpdateCJServlet")
public class UpdateCJServlet extends HttpServlet{
	
	/**
	 * Escapa caracteres indeseados
	 * 
	 * @param s
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	protected String sanitize(String s) throws UnsupportedEncodingException {		
		String response= new String(s.getBytes("ISO-8859-1"),"UTF-8");
		return response;
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String email = req.getParameter("email");
		String careerId = req.getParameter("careerId");
		String cjId = req.getParameter("currentJobId");
		String cat = req.getParameter("cat");
		String ent = req.getParameter("ent");
		String day = req.getParameter("day");
		String month = req.getParameter("month");
		String year = req.getParameter("year");
		
		int errorTag = 0;
		
		CareerDAO cdao = CareerDAOImplementation.getInstance();
		CurrentJobDAO cjdao = CurrentJobDAOImplementation.getInstance();
		Long cId = new Long(Integer.parseInt(careerId));
		Career career = cdao.read(cId);
		
		
		
		if(test(cat,ent,day,month,year)) {
			if(isSomethingEmpty(cat,ent,day,month,year)) {
				errorTag=1;
			}
		}else {
			CurrentJob cj;
			if((cjId == null) || cjId.isEmpty()) {
				cj = new CurrentJob();
			}else {
				Long currentJobId = new Long(Integer.parseInt(cjId));
				cj = cjdao.read(currentJobId);
			}
			try {
				cj.setCategory(sanitize(cat));
				cj.setEmployer(sanitize(ent));
				cj.setStart(getDateFromData(year,month,day));
				cj.setCareer(career);
				if((cjId == null) || cjId.isEmpty()) {
					cjdao.create(cj);
				}else {
					cjdao.update(cj);
				}
			}catch(Exception e) {
				errorTag = 4;
			}

		}
		resp.sendRedirect( req.getContextPath() + "/CareerServlet?email=" + email +"&errorTag=" + errorTag);
	}
	private boolean test(String a, String b, String c, String d, String e) {
		return (a == null || b == null || c == null || d == null || e == null || a.isEmpty() || b.isEmpty() || c.isEmpty() || d.isEmpty() || e.isEmpty());
	}
	
	private boolean isSomethingEmpty(String a, String b, String c, String d, String e) {
		return ((!a.isEmpty() || !b.isEmpty() || !c.isEmpty() || !d.isEmpty() || !e.isEmpty())!=(!a.isEmpty() && !b.isEmpty() && !c.isEmpty() && !d.isEmpty() && !e.isEmpty()));
	}
	
	public java.sql.Date getDateFromData(String year, String month,String day) throws Exception{
		int yearInt = Integer.parseInt(year);
		int monthInt = Integer.parseInt(month);
		int dayInt = Integer.parseInt(day);

		if ((yearInt<1900)|| (monthInt > 12) || (monthInt < 1)){
			throw new Exception("fecha erronea");
		}
		
		switch (monthInt){
		case 	1:
		case	3:
		case	5:
		case	7:
		case	8:
		case	10:
		case	12:
			if (dayInt < 1 || dayInt > 31) {
				throw new Exception("fecha erronea");
			}
			break;
		case 	4:
		case	6:
		case	9:
		case	11:
			if (dayInt < 1 || dayInt > 30) {
				throw new Exception("fecha erronea");
			}
			break;
		case 2:
			if((yearInt % 4 == 0) && ((yearInt % 100 != 0) || (yearInt % 400 == 0))) {
				if (dayInt < 1 || dayInt > 29 ) {
					throw new Exception("fecha erronea");
				}
			}else {
				if (dayInt < 1 || dayInt > 28) {
					throw new Exception("fecha erronea");
				}
			}
			break;
		}
		
		
		try {
			Calendar cal = Calendar.getInstance();
			cal.clear();
			cal.set(Calendar.YEAR, yearInt);
			cal.set(Calendar.MONTH, monthInt - 1);
			cal.set(Calendar.DATE, dayInt);
			Calendar today = Calendar.getInstance();
			today.getTime();
			if (cal.after(today)){
				throw new Exception("fecha erronea");
			}
			java.sql.Date date = new java.sql.Date(cal.getTimeInMillis());
			return date;
		}catch(Exception e) {
			throw new Exception("fecha erronea");
		}
	}
}
