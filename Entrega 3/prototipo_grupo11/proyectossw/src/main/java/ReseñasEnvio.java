/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author ruben
 */
@WebServlet(urlPatterns = {"/ReseñasEnvio"})
public class ReseñasEnvio extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PruebaServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PruebaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");


        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String bar = (String) request.getSession().getAttribute("nombre"); 

            String descripcion = request.getParameter("contenido");   
            //out.println(descripcion);
            String calificacion = request.getParameter("estrellas");
            //out.print("Estrellas: " + calificacion);
            String usuario = (String) request.getSession().getAttribute("username");
            //out.println(usuario);
            //out.println(bar);
            Timestamp fechaActual = new Timestamp(System.currentTimeMillis());
            
            insertarReseña(usuario, bar, descripcion, calificacion, fechaActual);
            String redireccion="DetallesBar/"+bar+"/Rese%C3%B1a";
            response.sendRedirect(redireccion);

            /*
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PruebaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");*/
        }
        
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

    private void insertarReseña(String usuario, String bar, String descripcion, String calif, Timestamp fecha) {
    try {      
        System.out.println("Entras!");
        // Establecer la conexión a la base de datos
        Class.forName("org.mariadb.jdbc.Driver");
        System.out.println("Connected to database!");
        String url = "jdbc:mariadb://localhost:3306/mysql";
        String user = "root";
        String passwd = "root";
        Connection conn = DriverManager.getConnection(url, user, passwd);
                
        String sql = "INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES (?, ?, ?, ?, ?)";
        
        BigDecimal calificacion = new BigDecimal(calif);
        
        System.out.println(calificacion);
        
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, usuario);
        stmt.setString(2, bar);
        stmt.setString(3, descripcion);
        stmt.setBigDecimal(4, calificacion);
        stmt.setTimestamp(5, fecha);

        int rows = stmt.executeUpdate();
        System.out.println(rows);

        // Cerrar la conexión a la base de datos
        conn.close();

        // Generar respuesta

        } catch (Exception ex) {

        }
}
    
    
}
