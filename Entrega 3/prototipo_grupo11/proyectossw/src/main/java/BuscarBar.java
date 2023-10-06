
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
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
    String nombre = request.getParameter("nombre");
    if (nombre == null){
        nombre = "";
    }
    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/mysql";
        String user = "root";
        String passwd = "root";
        Connection conn = DriverManager.getConnection(url, user, passwd);
        // Verificar si el correo ya está registrado
        String sqlVal = "SELECT * FROM bar b INNER JOIN (SELECT r.bar, AVG(r.calificacion) as valoracion_media FROM reseña r GROUP BY r.bar) p ON p.bar=b.nombre WHERE b.nombre LIKE ?";
        PreparedStatement stmt = conn.prepareStatement(sqlVal);
        stmt.setString(1, "%" + nombre + "%");
        ResultSet rs = stmt.executeQuery();
        misesion.setAttribute("listabares", rs);
        
        response.sendRedirect("busquedaBar.jsp");
    }catch (Exception ex) {
        System.out.println(ex.getMessage());
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

