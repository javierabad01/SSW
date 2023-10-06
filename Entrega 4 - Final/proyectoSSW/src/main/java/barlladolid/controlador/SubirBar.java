/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package barlladolid.controlador;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author javie
 */
@WebServlet(name = "SubirBar", urlPatterns = {"/SubirBar"})
@MultipartConfig
public class SubirBar extends HttpServlet {

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
            out.println("<title>Servlet SubirBar</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubirBar at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        
        String nombre = request.getParameter("bar");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String tipo = request.getParameter("tiposBar");
        String dueño = (String) request.getSession().getAttribute("username");
        String descripcion = request.getParameter("descBar");
        String[] caracteristicasbar = request.getParameterValues("carBar");
        String inicio = request.getParameter("openingTime");
        String fin = request.getParameter("closingTime");
        String[] dias = request.getParameterValues("day");
        
        if (direccion.contains("undefined")) {
            direccion = direccion.replace(" undefined", "");
        }
        
        //String path = "C:\\Users\\Pepe\\Documents\\sswRepository";
        String path = getServletContext().getRealPath("/imagenes");
        try {
            Part filePart = request.getPart("file");
            String fileName = getFileName(filePart);
            InputStream fileContent = filePart.getInputStream();
            OutputStream outFile = null;
            try {
                outFile = new FileOutputStream(new File(path + File.separator
                + fileName));
                int read = 0;
                byte[] bytes = new byte[1024];
                while ((read = fileContent.read(bytes)) != -1) {
                    outFile.write(bytes, 0, read);
                }
                String foto=("/imagenes/"+fileName);
                Consultor c = new Consultor(request);
                String sql = "INSERT INTO bar (dueño, nombre, descripcion, direccion, telefono, tipo, foto) VALUES (?, ?, ?, ?, ?, ?, ?)";
                ArrayList<String> values = new ArrayList<>();
                values.add(dueño);
                values.add(nombre);
                values.add(descripcion);
                values.add(direccion);
                values.add(telefono);
                values.add(tipo);
                values.add(foto);
                c.insertarValor(sql, values);
                
                String sqlCar = "INSERT INTO caracteristicasbar (bar, caracteristica) VALUES (?, ?)";

                for (int i=0;i< caracteristicasbar.length;i++){
                    ArrayList<String> valuesCar = new ArrayList<>();
                    valuesCar.add(nombre);
                    valuesCar.add(caracteristicasbar[i]);
                    c.insertarValor(sqlCar, valuesCar);
                }
                
                

            } catch (Exception ex) {  
            } finally {
                if (outFile != null) {
                    outFile.close();
                }
                if (fileContent != null) {
                    fileContent.close();
                }

            } 
        Consultor consultor = new Consultor(request);
        
        String insertSql = "INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES (?, ?, ?, ?)";
        for (String diaSemana : dias) {
            ArrayList<String> values = new ArrayList<>();
            values.add(nombre);
            values.add(diaSemana);
            values.add(inicio);
            values.add(fin);
            try {
              consultor.insertarValor(insertSql, values);
            } catch (SQLException e) {
              // Handle any errors
              e.printStackTrace();
            }
        }
        } catch (Exception ex){} 
            


        response.sendRedirect("PaginaPrincipal");
    }


    private static String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"","");
                return fileName.substring(fileName.lastIndexOf('/') +
                1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
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
