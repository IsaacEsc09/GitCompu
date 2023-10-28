package icc;

import java.util.Scanner;

import icc.colors.Colors;
import icc.figuras.Circulo;

public class Prueba {

    public static int getInt(String mensaje, String error, int min, int max) {
        int val;
        Scanner scn = new Scanner(System.in);

        while (true) {
            Colors.println(mensaje,Colors.WHITE+Colors.HIGH_INTENSITY);
            if (scn.hasNextInt()) {
                val = scn.nextInt();
                // (-infinito, min) || (max, infinito)
                if (val < min || max < val) {
                    System.out.println(error);
                } else {
                    return val;
                }
            } else {
                scn.next();
                System.out.println(error);
            }
        }
    }

    public static double getDouble(String mensaje, String error, double min, double max) {
        double val;
        Scanner scn = new Scanner(System.in);

        while (true) {
            Colors.println(mensaje,Colors.WHITE+Colors.HIGH_INTENSITY);
            if (scn.hasNextDouble()) {
                val = scn.nextDouble();
                if (val < min || max < val) {
                    System.out.println(error);
                } else {
                    return val;
                }
            } else {
                scn.next();
                System.out.println(error);
            }
        }
    }

    public static void main(String args[]) {
        int opcion;
        String mensaje, error;
        Elipse e = null; // Declaración de la variable e fuera del bucle



        do {

            Colors.println("Este programa realiza algunas operaciones con la elipse.",Colors.WHITE+Colors.HIGH_INTENSITY);
            Colors.println("1. Obtener el perimetro de una elipse.",Colors.WHITE+Colors.HIGH_INTENSITY);
            Colors.println("2. Obtener el area de una elipse.",Colors.WHITE+Colors.HIGH_INTENSITY);
            Colors.println("3. Revisar si un circulo se encuentra en el borde de una elipse.",Colors.WHITE+Colors.HIGH_INTENSITY);
            Colors.println("0. Salir",Colors.WHITE+Colors.HIGH_INTENSITY);
            opcion = getInt("Escoje una opcion.", "Opción no válida. Introduce un número entre 0 y 3.", 0, 3);

            switch (opcion) {
                case 1: {
                    double mayor = getDouble("Ingresa el eje mayor del elipse.", "Valor no válido. Introduce un número mayor que 0.", 0.0, Double.MAX_VALUE);
                    double menor = getDouble("Ingresa el eje menor del elipse.", "Valor no válido. Introduce un número mayor que 0.", 0.0, Double.MAX_VALUE);

                    e = new Elipse(mayor, menor);
                    Colors.println("El perímetro de la elipse es: " + e.perimetro()+"\n",Colors.GREEN+Colors.HIGH_INTENSITY);
                    break;
                }
                case 2: {
                    double mayor = getDouble("Ingresa el eje mayor del elipse.", "Valor no válido. Introduce un número mayor que 0.", 0.0, Double.MAX_VALUE);
                    double menor = getDouble("Ingresa el eje menor del elipse.", "Valor no válido. Introduce un número mayor que 0.", 0.0, Double.MAX_VALUE);

                    e = new Elipse(mayor, menor);
                    Colors.println("El área de la elipse es: " + e.area()+"\n",Colors.GREEN+Colors.HIGH_INTENSITY);
                    break;
                }
                case 3: {
                    double mayor = getDouble("Ingresa el eje mayor del elipse.", "Valor no válido. Introduce un número mayor que 0.", 0.0, Double.MAX_VALUE);
                    double menor = getDouble("Ingresa el eje menor del elipse.", "Valor no válido. Introduce un número mayor que 0.", 0.0, Double.MAX_VALUE);

                    e = new Elipse(mayor, menor);

                    double radioCirculo = getDouble("Ingresa el radio del círculo.", "Valor no válido. Introduce un número mayor que 0.", 0.0, Double.MAX_VALUE);
                    Circulo circulo = new Circulo(radioCirculo);

                    if (e.encaja(circulo)) {
                        Colors.println("El círculo encaja con el de la elipse."+"\n",Colors.GREEN+Colors.HIGH_INTENSITY);
                    } else {
                        Colors.println("El círculo no encaja con el de la elipse."+"\n",Colors.RED+Colors.HIGH_INTENSITY);
                    }
                    break;
                }
                case 0: {
                    Colors.print("Vuelve pronto :)"+"\n",Colors.CYAN+Colors.HIGH_INTENSITY);
                    break;
                }
                default: {
                    Colors.println("Opción no válida. Introduce un número entre 0 y 3."+"\n",Colors.RED+Colors.HIGH_INTENSITY);
                    break;
                }
            }

        } while (opcion != 0);
    }

}