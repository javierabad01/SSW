/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package barlladolid.controlador;

import barlladolid.modelo.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author javie
 */
@WebServlet(name = "GeolocalizacionMapa", urlPatterns = {"/GeolocalizacionMapa"})
public class GeolocalizacionMapa extends HttpServlet {

    
    public void init(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Llame al método doGet al inicializar el servlet
    doGet(request, response);
}
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GeolocalizacionMapa</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GeolocalizacionMapa at " + request.getContextPath() + "</h1>");
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
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    try {
        HttpSession session = request.getSession();

        String sqlQuery = "SELECT * FROM bar";
        Consultor c = new Consultor(request);
        ResultSet rs = c.realizarConsulta(sqlQuery, null);

        // Crear lista de objetos Bar
        ArrayList<Bar> listaBares = new ArrayList<>();
        while (rs.next()) {
            Bar bar = new Bar();
            bar.setNombre(rs.getString("nombre"));
            bar.setDescripcion(rs.getString("descripcion"));
            bar.setDireccion(rs.getString("direccion"));
            bar.setTelefono(rs.getString("telefono"));
            bar.setTipo(rs.getString("tipo"));
            bar.setFoto(rs.getString("foto"));
            listaBares.add(bar);
        }
        
        // Almacenar lista de objetos Bar en HttpSession
        session.setAttribute("listaBares", listaBares);

        // Redirigir a la página JSP
        response.sendRedirect("Mapa.jsp");
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Call the processRequest method to process the form data
    // Check if there is an error
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String mensajeError = (String) request.getSession().getAttribute("mensajeError");
    if (mensajeError != null && !mensajeError.isEmpty()) {
        // If there is an error, redirect back to the JSP page
        response.sendRedirect("mapa.jsp");
    } else {
        // If there is no error, go to the success page
        response.sendRedirect("mapa.jsp");
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

}
