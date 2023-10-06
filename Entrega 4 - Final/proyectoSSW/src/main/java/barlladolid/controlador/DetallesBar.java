package barlladolid.controlador;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import barlladolid.modelo.Bar;
import barlladolid.modelo.Horario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.time.LocalTime;
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
            String[] ruta=request.getPathInfo().split("/");
            String nombreBarUrl=ruta[1];
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
            Consultor c = new Consultor(request);
            
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
            String sqlhorario = "SELECT * FROM horario WHERE bar=\""+nombreBarUrl+"\"";
            String sqlcarac = "SELECT * FROM caracteristicasbar WHERE bar=\""+nombreBarUrl+"\"";

            ResultSet rs = c.realizarConsulta(sql, null);
            ResultSet rs2 = c.realizarConsulta(sqlVal, null);
            ResultSet rs3 = c.realizarConsulta(sqlUltVal, null);
            ResultSet rs4 = c.realizarConsulta(sqlhorario, null);
            ResultSet rs5 = c.realizarConsulta(sqlcarac, null);


            while (rs.next()){
                dueño = rs.getString("dueño");
                nombre = rs.getString("nombre");
                descripcion = rs.getString("descripcion");
                direccion = rs.getString("direccion");
                telefono = rs.getString("telefono");
                tipo = rs.getString("tipo");
                foto = rs.getString("foto");
            }
                //System.out.println(foto);
            if (rs2.next()) {
                valoracionMedia = rs2.getFloat("valoracion_media");
            }
            

            while (rs3.next()){
                String calificacion = rs3.getString("ultCal");
                ultimasValoraciones.add(calificacion);
            }
            
            ArrayList<Horario> horarios = new ArrayList<>();
            while (rs4.next()){
                Horario h = new Horario();
                h.setDiaSemana(rs4.getString("diaSemana"));
                LocalTime ini = LocalTime.parse(rs4.getString("inicio"));
                h.setInicio(ini);
                LocalTime fin = LocalTime.parse(rs4.getString("fin"));
                h.setFin(fin);
                horarios.add(h);
            }
            
            ArrayList<String> caracteristicas = new ArrayList<>();
            while(rs5.next()){
                caracteristicas.add(rs5.getString("caracteristica"));
            }
            
            Bar miBar = new Bar();
            miBar.setDueno(dueño);
            miBar.setNombre(nombre);
            miBar.setDescripcion(descripcion);
            miBar.setDireccion(direccion);
            miBar.setTelefono(telefono);
            miBar.setTipo(tipo);
            miBar.setFoto(foto);
            

            request.getSession().setAttribute("miBar",miBar);
            request.getSession().setAttribute("valoracionMedia", valoracionMedia);
            request.getSession().setAttribute("ultimasValoraciones", ultimasValoraciones);
            //request.getSession().setAttribute("dueño", dueño);
            request.getSession().setAttribute("nombre", nombre);
            request.getSession().setAttribute("horarios", horarios);
            request.getSession().setAttribute("caracteristicas", caracteristicas);
            /*request.getSession().setAttribute("descripcion", descripcion);
            request.getSession().setAttribute("direccion", direccion);
            request.getSession().setAttribute("telefono", telefono);
            request.getSession().setAttribute("tipo", tipo);
            request.getSession().setAttribute("foto", foto); */
            
            
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
