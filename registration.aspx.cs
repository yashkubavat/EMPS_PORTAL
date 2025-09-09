using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace EMPS_PORTAL
{
    public partial class registration : System.Web.UI.Page
    {
        SqlCommand cmd;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter ad;
        string fnm;
        int i;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void uploadimg()
        {
            if (fldimg.HasFile)
            {
                fnm = "image/" + fldimg.FileName;
                fldimg.SaveAs(Server.MapPath(fnm));
            }

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            getcon();
            uploadimg();
            if (Button1.Text == "Register")
            {
                cmd = new SqlCommand("insert into emp_tbl(Name, Email, Password, Mobile, City, Gender, Image) values ('" + txtun.Text + "', '" + txtem.Text + "', '" + txtpass.Text + "', '" + txtmo.Text + "', '" + txtct.Text + "', '" + rdbgd.Text + "', '" + fnm + "')", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script>alert('Register successfully!!!')</script>");
                    Response.Redirect("login.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Register failed!!!')</script>");
                }
            }
        }
    }
}