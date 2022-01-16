import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class GekkITMzh extends JFrame {
    JButton GeekITmzh;
    JLabel GekkITmzhMYNEWBlog;

    public GekkITMzh() {
        GekkITMzhLayout customLayout = new GekkITMzhLayout();

        getContentPane().setFont(new Font("Helvetica", Font.PLAIN, 12));
        getContentPane().setLayout(customLayout);

        GeekITmzh = new JButton("https://geekitmzh.netlify.app/");
        getContentPane().add(GeekITmzh);

        GekkITmzhMYNEWBlog = new JLabel("https://geekitmzh.netlify.app");
        getContentPane().add(GekkITmzhMYNEWBlog);

        setSize(getPreferredSize());

        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
    }

    public static void main(String args[]) {
        GekkITMzh window = new GekkITMzh();

        window.setTitle("GekkITMzh");
        window.pack();
        window.show();
    }
}

class GekkITMzhLayout implements LayoutManager {

    public GekkITMzhLayout() {
    }

    public void addLayoutComponent(String name, Component comp) {
    }

    public void removeLayoutComponent(Component comp) {
    }

    public Dimension preferredLayoutSize(Container parent) {
        Dimension dim = new Dimension(0, 0);

        Insets insets = parent.getInsets();
        dim.width = 740 + insets.left + insets.right;
        dim.height = 405 + insets.top + insets.bottom;

        return dim;
    }

    public Dimension minimumLayoutSize(Container parent) {
        Dimension dim = new Dimension(0, 0);
        return dim;
    }

    public void layoutContainer(Container parent) {
        Insets insets = parent.getInsets();

        Component c;
        c = parent.getComponent(0);
        if (c.isVisible()) {c.setBounds(insets.left+240,insets.top+240,240,64);}
        c = parent.getComponent(1);
        if (c.isVisible()) {c.setBounds(insets.left+272,insets.top+112,168,72);}
    }
}
