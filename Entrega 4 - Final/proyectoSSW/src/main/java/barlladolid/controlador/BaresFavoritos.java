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
@WebServlet(name = "BaresFavoritos", urlPatterns = {"/BaresFavoritos"})
public class BaresFavoritos extends HttpServlet {

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
            out.println("<title>Servlet BaresFavoritos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BaresFavoritos at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Consulta la base de datos para verificar si el bar está en favoritos
        String username = request.getParameter("username");
        String barName = request.getParameter("barName");
        // Consulta la base de datos para verificar si el bar está en favoritos para el usuario
        boolean isFavorite = false;
        try {
            Consultor c = new Consultor(request);
            ArrayList<String> values = new ArrayList<>();
            values.add(username);
            values.add(barName);
            ResultSet rs = c.realizarConsulta("SELECT * FROM favoritos WHERE usuario = ? AND bar = ?", values);
            if (rs.next()){
                isFavorite = true; 
            }
        } catch (SQLException e) {
            // Maneja la excepción
        }
        
        // Envía la respuesta al cliente
        response.setContentType("application/json");
        String jsonResponse = "{\"isFavorite\": " + isFavorite + "}";
        PrintWriter out = response.getWriter();
        out.println(jsonResponse);

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtén el nombre de usuario, el nombre del bar y la acción desde los parámetros de la solicitud
        String username = request.getParameter("username");
        String barName = request.getParameter("barName");
        String action = request.getParameter("action");

        // Realiza la acción correspondiente
        try {
            Consultor c = new Consultor(request);
            ArrayList<String> values = new ArrayList<>();
            values.add(username);
            values.add(barName);
            if ("remove".equals(action)) {
                c.insertarValor("DELETE FROM favoritos WHERE usuario = ? AND bar = ?", values);
            } else if ("add".equals(action)) {
                c.insertarValor("INSERT INTO favoritos (usuario, bar) VALUES (?, ?)", values);
            }
        } catch (SQLException e) {
            // Maneja la excepción
        }

        // Envía una respuesta vacía al cliente
        response.setStatus(HttpServletResponse.SC_NO_CONTENT);

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
