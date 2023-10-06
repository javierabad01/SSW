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
import javax.servlet.http.HttpSession;

/**
 *
 * @author ruben
 */
@WebServlet(urlPatterns = {"/Perfil"})
public class Perfil extends HttpServlet {

    
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

            RequestDispatcher RequetsDispatcherObj = request.getRequestDispatcher("/perfil.jsp");
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try  {
            /* TODO output your page here. You may use following sample code. */
            String username = (String) request.getSession().getAttribute("username");
            
            Consultor c = new Consultor(request);

            muestraFavoritos(username, request, c);

            muestraPromocionados(username, request, c);
            
            muestraReseñas(username, request, c);
        }
        catch (Exception ex){
            
        }
        
        //processRequest(request, response);
        response.sendRedirect("perfil.jsp");

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        cierraSesion(request, response);
        
    }


    private void muestraFavoritos(String usuario, HttpServletRequest request, Consultor c) {
    try {      
        System.out.println("Entras!");
        // Establecer la conexión a la base de datos
           
        String sql = "SELECT f.bar, b.foto FROM favoritos f inner join bar b on b.nombre=f.bar WHERE f.usuario=\""+usuario+"\"";
        
                        
     
        
        ArrayList<String> barFav = new ArrayList<>();
        ArrayList<String> fotoFav = new ArrayList<>();
        /*tempRes.add(usuario);
        tempRes.add(bar);
        tempRes.add(descripcion);
        tempRes.add(calificacion.toString());
        tempRes.add(fecha.toString());*/
      
        ResultSet rs=c.realizarConsulta(sql, null);
        while (rs.next()){
            String nombre = rs.getString("bar");
            barFav.add(nombre);
            String imagen = rs.getString("foto");
            fotoFav.add(imagen);
            }
        
        //int rows = stmt.executeUpdate();
        //System.out.println(rows);
                
        // Cerrar la conexión a la base de datos

        // Generar respuesta
        request.getSession().setAttribute("barFav", barFav);
        request.getSession().setAttribute("fotoFav", fotoFav);
        } catch (Exception ex) {

        }
}
    
     private void muestraPromocionados(String usuario, HttpServletRequest request, Consultor c) {
         
        String sql = "SELECT b.nombre, b.foto FROM  bar b WHERE b.dueño=\""+usuario+"\"";




         ArrayList<String> barP = new ArrayList<>();
         ArrayList<String> fotoP = new ArrayList<>();
    try {      
         System.out.println("Entras!");
         // Establecer la conexión a la base de datos

        
         /*tempRes.add(usuario);
         tempRes.add(bar);
         tempRes.add(descripcion);
         tempRes.add(calificacion.toString());
         tempRes.add(fecha.toString());*/

         ResultSet rs2=c.realizarConsulta(sql, null);
         
        while (rs2.next()){
            String nombre = rs2.getString("nombre");
            barP.add(nombre);
            String imagen = rs2.getString("foto");
            fotoP.add(imagen);
            System.out.println("nombre: " + nombre + ", imagen: " + imagen);

            }

        //int rows = stmt.executeUpdate();
        //System.out.println(rows);

        // Cerrar la conexión a la base de datos
        System.out.println(barP);

        // Generar respuesta

        } catch (Exception ex) {
           ex.printStackTrace();

        }
        request.getSession().setAttribute("barP", barP);
        request.getSession().setAttribute("fotoP", fotoP);
}
    
    private void muestraReseñas(String usuario, HttpServletRequest request, Consultor c) {
    try {      
        String descripcion = null;
        String bar = null;
        ArrayList<String> barRes = new ArrayList<>();
        ArrayList<String> descRes = new ArrayList<>();

        
        //Connection conn = DriverManager.getConnection(url, user, passwd);
                
        String sql = "SELECT r.bar, r.descripcion FROM reseña r WHERE r.usuario=\""+usuario+"\" ORDER BY fecha desc";
        ResultSet rs=c.realizarConsulta(sql, null);
        /*PreparedStatement stmt2 = conn.prepareStatement(sql);
        ResultSet rs = stmt2.executeQuery();                

        System.out.println(sql);
        */
        while (rs.next()){
            bar = rs.getString("bar");
            barRes.add(bar);
            descripcion = rs.getString("descripcion");
            descRes.add(descripcion);
            }
        
            request.getSession().setAttribute("barRes", barRes);
        request.getSession().setAttribute("descRes", descRes);

        } catch (Exception ex) {

        }
}
    
    
    private void cierraSesion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Obtiene la sesión
        
        if (session != null) {
            session.invalidate(); // Invalida la sesión actual
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
