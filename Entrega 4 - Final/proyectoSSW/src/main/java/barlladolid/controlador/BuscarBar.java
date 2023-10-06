package barlladolid.controlador;

import barlladolid.modelo.Bar;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/BuscarBar"})
public class BuscarBar extends HttpServlet {

    private static final long serialVersionUID = 1L;

private void mostrarError(String mensaje, PrintWriter out) {
    out.println("<!DOCTYPE HTML>");
    out.println("<html>");
    out.println("<head>");
    out.println("<title>Error</title>");
    out.println("</head>");
    out.println("<body>");
    out.println("<h1>Error</h1>");
    out.println("<p>" + mensaje + "</p>");
    out.println("</body>");
    out.println("</html>");
}

protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    try {
    HttpSession misesion =  request.getSession();
    String nombre = "%" + request.getParameter("nombre") + "%";
    String option = request.getParameter("select");
    String orden = "";
    
    switch (option){
        case "maxval":
            orden = "p.valoracion_media DESC";
            break;
        case "minval":
            orden = "p.valoracion_media ASC";
            break;
        case "alf":
            orden = "t.nombre ASC";
            break;
        case "revalf":
            orden = "t.nombre DESC";
            break;
        default:
            orden = "p.valoracion_media DESC";
            break;
    } 
            


        String sqlVal = "SELECT DISTINCT t.nombre, p.valoracion_media, t.foto FROM (SELECT * FROM bar b LEFT OUTER JOIN caracteristicasbar c on b.nombre = c.bar) t LEFT OUTER JOIN (SELECT r.bar, AVG(r.calificacion) as valoracion_media FROM reseña r GROUP BY r.bar) p ON p.bar=t.nombre WHERE t.nombre LIKE \"" + nombre + "\"";
        String[] calif = request.getParameterValues("calif");
        if(calif != null){
            sqlVal = sqlVal + " AND (";
            for(String c:calif){
                int numc = Integer.parseInt(c);
                sqlVal = sqlVal + "(p.valoracion_media >= " + (numc-1) + " AND p.valoracion_media <= " + numc +") OR ";
            }
            sqlVal = sqlVal.substring(0, sqlVal.length()-4);
            sqlVal = sqlVal + ")";
        }
        
        String[] tipo = request.getParameterValues("tipo");
        if(tipo != null){
            sqlVal = sqlVal + " AND (";
            for(String t:tipo){
                sqlVal = sqlVal + "t.tipo = \"" + t + "\" OR ";
            }
            sqlVal = sqlVal.substring(0, sqlVal.length()-4);
            sqlVal = sqlVal + ")";
        }
        
        
        String[] carac = request.getParameterValues("carac");
        if(carac != null){
            sqlVal = sqlVal + " AND (";
            for(String cr:carac){
                sqlVal = sqlVal + "t.caracteristica = \"" + cr + "\" OR ";
            }
            sqlVal = sqlVal.substring(0, sqlVal.length()-4);
            sqlVal = sqlVal + ")";
        }
        
        
        sqlVal = sqlVal + " ORDER BY " + orden;
        Consultor c = new Consultor(request);
        ResultSet rs = c.realizarConsulta(sqlVal, null);
        ArrayList<Bar> listabares = new ArrayList<>(); 
        while(rs.next()){
            Bar b = new Bar();
            b.setFoto(rs.getString("foto"));
            b.setNombre(rs.getString("nombre"));
            b.setVal(rs.getFloat("valoracion_media"));
            listabares.add(b);
        }
        misesion.setAttribute("listabares", listabares);
        response.sendRedirect("busquedaBar.jsp");
    }catch (Exception ex) {
        response.sendRedirect("busquedaBar.jsp");

    }
    
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Call the processRequest method to process the form data
    // Check if there is an error
    String mensajeError = (String) request.getSession().getAttribute("mensajeError");
    if (mensajeError != null && !mensajeError.isEmpty()) {
        // If there is an error, redirect back to the JSP page
        response.sendRedirect("busquedaBar.jsp");
    } else {
        // If there is no error, go to the success page
        response.sendRedirect("busquedaBar.jsp");
    }
}
}

