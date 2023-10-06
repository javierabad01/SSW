/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package barlladolid.controlador;

import barlladolid.modelo.Bar;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ActualizaBar", urlPatterns = {"/ActualizaBar"})
public class ActualizaBar extends HttpServlet {

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
            out.println("<title>Servlet ActualizaBar</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActualizaBar at " + request.getContextPath() + "</h1>");
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
        // Obtener el nuevo valor de la descripción de los parámetros de la solicitud
        System.out.println("Recibiendo solicitud de ActualizaBar...");

        // Obtener el objeto miBar de la sesión
        Bar miBar = (Bar) request.getSession().getAttribute("miBar");

        // Crear una instancia de la clase Consultor
        Consultor consultor = new Consultor(request);

        // Verificar qué campo se está actualizando
        if (request.getParameter("descripcion") != null) {
            // Actualizar la descripción de miBar
            String nuevaDescripcion = request.getParameter("descripcion");
            miBar.setDescripcion(nuevaDescripcion);

            // Actualizar el valor en la base de datos
            String consulta = "UPDATE bar SET descripcion = ? WHERE nombre = ?";
            ArrayList<String> values = new ArrayList<>();
            values.add(nuevaDescripcion);
            values.add(miBar.getNombre());
            try {
                consultor.insertarValor(consulta, values);
            } catch (SQLException ex) {
                Logger.getLogger(ActualizaBar.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("direccion") != null) {
            // Actualizar la dirección de miBar
            String nuevaDireccion = request.getParameter("direccion");
            miBar.setDireccion(nuevaDireccion);

            // Actualizar el valor en la base de datos
            String consulta = "UPDATE bar SET direccion = ? WHERE nombre = ?";
            ArrayList<String> values = new ArrayList<>();
            values.add(nuevaDireccion);
            values.add(miBar.getNombre());
            try {
                consultor.insertarValor(consulta, values);
            } catch (SQLException ex) {
                Logger.getLogger(ActualizaBar.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        } else if (request.getParameter("telefono") != null) {
            // Actualizar el teléfono de miBar
            String nuevoTelefono = request.getParameter("telefono");
            miBar.setTelefono(nuevoTelefono);

            // Actualizar el valor en la base de datos
            String consulta = "UPDATE bar SET telefono = ? WHERE nombre = ?";
            ArrayList<String> values = new ArrayList<>();
            values.add(nuevoTelefono);
            values.add(miBar.getNombre());
            try {
                consultor.insertarValor(consulta, values);
            } catch (SQLException ex) {
                Logger.getLogger(ActualizaBar.class.getName()).log(Level.SEVERE, null, ex);
            }
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
