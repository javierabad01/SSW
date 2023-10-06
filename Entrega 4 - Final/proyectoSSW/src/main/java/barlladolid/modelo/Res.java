/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package barlladolid.modelo;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author ruben
 */
  public class Res {
  private String usuario;
  private String bar;
  private String descripcion;
  private int calificacion;
  private Timestamp fecha;

  public Res(String usuario, String bar, String descripcion, int calificacion, Timestamp fecha) {
    this.usuario = usuario;
    this.bar = bar;
    this.descripcion = descripcion;
    this.calificacion = calificacion;
    this.fecha = fecha;
  }

  // Getters y setters para los atributos de la clase

  public String getUsuario() {
    return usuario;
  }

  public void setUsuario(String usuario) {
    this.usuario = usuario;
  }

  public String getBar() {
    return bar;
  }

  public void setBar(String bar) {
    this.bar = bar;
  }

  public String getDescripcion() {
    return descripcion;
  }

  public void setDescripcion(String descripcion) {
    this.descripcion = descripcion;
  }

  public int getCalificacion() {
    return calificacion;
  }

  public void setCalificacion(int calificacion) {
    this.calificacion = calificacion;
  }

  public Timestamp getFecha() {
    return fecha;
  }

  public void setFecha(Timestamp fecha) {
    this.fecha = fecha;
  }
}
