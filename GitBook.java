import java.awt.*;
import java.awt.event.*;
import java.applet.Applet;
import javax.swing.*;

public class GitBook extends JApplet {
    JButton GitBook;

    public void init() {
        GitBookLayout customLayout = new GitBookLayout();

        getContentPane().setFont(new Font("Helvetica", Font.PLAIN, 12));
        getContentPane().setLayout(customLayout);

        GitBook = new JButton("https://www.gitbook.com/");
        getContentPane().add(GitBook);

        setSize(getPreferredSize());

    }

    public static void main(String args[]) {
        GitBook applet = new GitBook();
        JFrame window = new JFrame("GitBook");

        window.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        applet.init();
        window.getContentPane().add("Center", applet);
        window.pack();
        window.setVisible(true);
    }
}

class GitBookLayout implements LayoutManager {

    public GitBookLayout() {
    }

    public void addLayoutComponent(String name, Component comp) {
    }

    public void removeLayoutComponent(Component comp) {
    }

    public Dimension preferredLayoutSize(Container parent) {
        Dimension dim = new Dimension(0, 0);

        Insets insets = parent.getInsets();
        dim.width = 320 + insets.left + insets.right;
        dim.height = 240 + insets.top + insets.bottom;

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
        if (c.isVisible()) {c.setBounds(insets.left+72,insets.top+96,168,88);}
    }
}
