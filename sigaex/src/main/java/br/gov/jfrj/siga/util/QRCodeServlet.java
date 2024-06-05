package br.gov.jfrj.siga.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.common.BitMatrix;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

public class QRCodeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("image/png");

        String qrText = request.getParameter("data");
        int size = 200;
        QRCodeWriter writer = new QRCodeWriter();
        BitMatrix bitMatrix;
        try {
            bitMatrix = writer.encode(qrText, BarcodeFormat.QR_CODE, size, size);
        } catch (WriterException e) {
            throw new IOException("Could not generate QR code", e);
        }

        BufferedImage image = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                image.setRGB(i, j, bitMatrix.get(i, j) ? 0xFF000000 : 0xFFFFFFFF);
            }
        }

        OutputStream os = response.getOutputStream();
        ImageIO.write(image, "png", os);
        os.close();
    }
}
