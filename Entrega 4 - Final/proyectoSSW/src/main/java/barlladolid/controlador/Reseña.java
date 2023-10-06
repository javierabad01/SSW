package barlladolid.controlador;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import barlladolid.modelo.Bar;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import barlladolid.modelo.Res;

/**
 *
 * @author ruben
 */
@WebServlet(urlPatterns = {"/Reseña"})
public class Reseña extends HttpServlet {
    
    ArrayList<Res> listaReseñas = new ArrayList<>();
    
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
        try (PrintWriter out = response.getWriter()){
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Probando123</title>");

            RequestDispatcher RequetsDispatcherObj = request.getRequestDispatcher("/Reseñas.jsp");
            RequetsDispatcherObj.forward(request, response);
            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PruebaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            

            } catch (Exception ex) {
                
                System.out.println(ex.getMessage());
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
        try  {
            /* TODO output your page here. You may use following sample code. */
            String bar = (String) request.getSession().getAttribute("nombre"); 
            Consultor c = new Consultor(request);

            muestraReseñas(bar, request, c);
        }
        catch (Exception ex){
            
        }
        
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

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Bar miBar = (Bar) request.getSession().getAttribute("miBar");
            String bar = miBar.getNombre();

            String descripcion = request.getParameter("contenido");   
            //out.println(descripcion);
            String calificacion = request.getParameter("estrellas");
            //out.print("Estrellas: " + calificacion);
            String usuario = (String) request.getSession().getAttribute("username");
            //out.println(usuario);
            out.println(bar);
            Timestamp fechaActual = new Timestamp(System.currentTimeMillis());
            
            Consultor c = new Consultor(request);
            insertarReseña(usuario, bar, descripcion, calificacion, fechaActual, c);
           
        }
        
    }


    private void insertarReseña(String usuario, String bar, String descripcion, String calif, Timestamp fecha, Consultor c) {
    try {      
        System.out.println("Entras!");
        // Establecer la conexión a la base de datos
        Class.forName("org.mariadb.jdbc.Driver");
        System.out.println("Connected to database!");
        String url = "jdbc:mariadb://localhost:3306/mysql";
        String user = "root";
        String passwd = "root";
        
        

                
        String sql = "INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES (?, ?, ?, ?, ?)";
        
        
        BigDecimal calificacion = new BigDecimal(calif);
        
        
        /*PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, usuario);
        stmt.setString(2, bar);
        stmt.setString(3, descripcion);
        stmt.setBigDecimal(4, calificacion);
        stmt.setTimestamp(5, fecha);*/
        
        ArrayList<String> tempRes = new ArrayList<>();
        /*tempRes.add(usuario);
        tempRes.add(bar);
        tempRes.add(descripcion);
        tempRes.add(calificacion.toString());
        tempRes.add(fecha.toString());*/
      
        c.realizarConsulta(sql, tempRes);

        
        //int rows = stmt.executeUpdate();
        //System.out.println(rows);
                
        // Cerrar la conexión a la base de datos

        // Generar respuesta

        } catch (Exception ex) {

        }
}
    
    private void muestraReseñas(String bar, HttpServletRequest request, Consultor c) {
    try {      
        
        String usuario = null;
        String descripcion = null;
        Timestamp fecha = null;
        ArrayList<String> usuarios = new ArrayList<>();
        ArrayList<String> descripciones = new ArrayList<>();
        ArrayList<Timestamp> fechas = new ArrayList<>();
        ArrayList<Integer> calificaciones = new ArrayList<>();

        
        int calificacion = 0;
        BigDecimal calificacion2 = null;
        //Connection conn = DriverManager.getConnection(url, user, passwd);
                
        String sql = "SELECT * FROM reseña WHERE bar=\""+bar+"\" ORDER BY fecha desc";
        ResultSet rs=c.realizarConsulta(sql, null);
        /*PreparedStatement stmt2 = conn.prepareStatement(sql);
        ResultSet rs = stmt2.executeQuery();                

        System.out.println(sql);
        */
        while (rs.next()){
            usuario = rs.getString("usuario");
            usuarios.add(usuario);
            descripcion = rs.getString("descripcion");
            descripciones.add(descripcion);
            calificacion = rs.getBigDecimal("calificacion").intValue();
            calificacion2 = rs.getBigDecimal("calificacion");
            calificaciones.add(calificacion);
            fecha = rs.getTimestamp("fecha");
            fechas.add(fecha);
            Res res =new Res(usuario, bar, descripcion, calificacion, fecha);
            listaReseñas.add(res);

            }
        request.getSession().setAttribute("usuarios", usuarios);
        request.getSession().setAttribute("descripciones", descripciones);
        request.getSession().setAttribute("calificaciones", calificaciones);
        request.getSession().setAttribute("fechas", fechas);
   
        

        } catch (Exception ex) {

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
