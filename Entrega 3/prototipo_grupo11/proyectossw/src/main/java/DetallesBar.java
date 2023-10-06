/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author javie
 */
@WebServlet(urlPatterns = {"/DetallesBar/*"})
public class DetallesBar extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            try {
            // Establecer la conexión a la base de datos
            Class.forName("org.mariadb.jdbc.Driver");
            String url = "jdbc:mariadb://localhost:3306/mysql";
            String user = "root";
            String passwd = "root";
            String[] ruta=request.getPathInfo().split("/");
            String nombreBarUrl=ruta[1];
            Connection conn = DriverManager.getConnection(url, user, passwd);
            String dueño = null;
            String nombre = null;
            String descripcion= null;
            String direccion=null;
            String telefono=null;
            String tipo=null;
            String foto = null;
            float valoracionMedia=0;
            ArrayList<String> ultimasValoraciones = new ArrayList<>();
            
            // Verificar si el correo ya está registrado
            String sql = "SELECT * FROM bar WHERE nombre=\""+nombreBarUrl+"\"";
            String sqlVal = "SELECT AVG(calificacion) as valoracion_media FROM reseña WHERE bar=\""+nombreBarUrl+"\"";
            String sqlUltVal = "SELECT r1.calificacion as ultCal " +
                                "FROM reseña r1 " +
                                "WHERE r1.bar = \""+nombreBarUrl+"\" " +
                                "AND (" +
                                "SELECT COUNT(*) " +
                                "FROM reseña r2 " +
                                "WHERE r2.bar = r1.bar " +
                                "AND r2.fecha > r1.fecha " +
                                ") < 2;";

            PreparedStatement stmt = conn.prepareStatement(sql);
            PreparedStatement stmt2 = conn.prepareStatement(sqlVal);
            PreparedStatement stmt3 = conn.prepareStatement(sqlUltVal);

            ResultSet rs = stmt.executeQuery();
            ResultSet rs2 = stmt2.executeQuery();
            ResultSet rs3 = stmt3.executeQuery();

            while (rs.next()){
                dueño = rs.getString("dueño");
                nombre = rs.getString("nombre");
                descripcion = rs.getString("descripcion");
                direccion = rs.getString("direccion");
                telefono = rs.getString("telefono");
                tipo = rs.getString("tipo");
                foto = rs.getString("foto");
            }
                System.out.println(foto);
            if (rs2.next()) {
                valoracionMedia = rs2.getFloat("valoracion_media");
            }
            

            while (rs3.next()){
                String calificacion = rs3.getString("ultCal");
                ultimasValoraciones.add(calificacion);
            }
           
            

            request.getSession().setAttribute("valoracionMedia", valoracionMedia);
            request.getSession().setAttribute("dueño", dueño);
            request.getSession().setAttribute("nombre", nombre);
            request.getSession().setAttribute("descripcion", descripcion);
            request.getSession().setAttribute("direccion", direccion);
            request.getSession().setAttribute("telefono", telefono);
            request.getSession().setAttribute("tipo", tipo);
            request.getSession().setAttribute("foto", foto);
            request.getSession().setAttribute("ultimasValoraciones", ultimasValoraciones);
            
            String uri = request.getRequestURI();
            Pattern pattern = Pattern.compile("(.*?)/Rese%C3%B1a");
            Matcher matcher = pattern.matcher(uri);
            if (matcher.find()) {
                String value = matcher.group(0);
                request.setAttribute("value", value);
                RequestDispatcher RequetsDispatcherObj = request.getRequestDispatcher("/Reseña");
                RequetsDispatcherObj.forward(request, response);
            } else {
                RequestDispatcher RequetsDispatcherObj =request.getRequestDispatcher("/bar.jsp");
                RequetsDispatcherObj.forward(request, response);                
            }
           
            
           
            
            
            
            
            } catch (Exception ex) {
                
                System.out.println(ex.getMessage());
            }          
            
            
            /*
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DetallesBar</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetallesBar at " + request.getPathInfo()+ "</h1>");
            out.println("</body>");
            out.println("</html>");
            */
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        // hay que utilizar el noseque get request dispatcher.
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
