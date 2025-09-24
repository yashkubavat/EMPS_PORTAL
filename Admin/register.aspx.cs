using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EMPS_PORTAL.Admin
{
    public partial class register : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con;
        SqlDataAdapter ad;
        DataSet ds;
        int i;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
       
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Register")
            {
                getcon();
                cmd = new SqlCommand("insert into admin_tbl (Name, Email, Password) values ('"+txtun.Text+"','"+txtem.Text+"','"+txtpass.Text+"')", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script>alert('Register successfully!!!')</script>");
                    Response.Redirect("index.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Register failed!!!')</script>");
                }
            }
        }
    }
}