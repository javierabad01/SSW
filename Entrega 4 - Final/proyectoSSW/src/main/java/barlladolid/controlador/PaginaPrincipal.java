/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package barlladolid.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author javie
 */
@WebServlet(name = "PaginaPrincipal", urlPatterns = {"/PaginaPrincipal"})
public class PaginaPrincipal extends HttpServlet {

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
            out.println("<title>Servlet PaginaPrincipal</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaginaPrincipal at " + request.getContextPath() + "</h1>");
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
        Consultor c = new Consultor(request);
        String sqlVal = "with maxCal as(SELECT bar, AVG(calificacion) as valoracion_media FROM reseña GROUP BY bar HAVING AVG(calificacion)) SELECT mc.bar, b.direccion, mc.valoracion_media, b.foto FROM maxCal mc inner join bar b on mc.bar=b.nombre ORDER BY mc.valoracion_media DESC LIMIT 2;";
         ArrayList<String> bares = new ArrayList<>();
        ArrayList<String> calificaciones = new ArrayList<>();
        ArrayList<String> fotos = new ArrayList<>();
        ArrayList<String> direcciones = new ArrayList<>();


        /*tempRes.add(usuario);
        tempRes.add(bar);
        tempRes.add(descripcion);
        tempRes.add(calificacion.toString());
        tempRes.add(fecha.toString());*/
      
        try {
            ResultSet rs = c.realizarConsulta(sqlVal, null);
            while (rs.next()){
            String bar = rs.getString("bar");
            bares.add(bar);
            String direccion = rs.getString("direccion");
            direcciones.add(direccion);
            String valoracion = rs.getString("valoracion_media");
            calificaciones.add(valoracion);
            String imagen = rs.getString("foto");
            fotos.add(imagen);
            }
         
            
            
        } catch (SQLException ex) {
            Logger.getLogger(PaginaPrincipal.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.getSession().setAttribute("baresInicio", bares);
        request.getSession().setAttribute("calificacionesInicio", calificaciones);
        request.getSession().setAttribute("fotosInicio", fotos);
        request.getSession().setAttribute("direccionesInicio", direcciones);

        response.sendRedirect("index.jsp");

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
