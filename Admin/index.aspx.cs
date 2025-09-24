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
    public partial class index : System.Web.UI.Page
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
            con=new SqlConnection(s);
            con.Open();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if(Button1.Text== "Login")
            {
                getcon();
                cmd = new SqlCommand("select count(*) from admin_tbl where Email='"+txtem.Text+"' and Password='"+txtpass.Text+"'", con);
                i=Convert.ToInt32(cmd.ExecuteScalar());
                if (i > 0)
                {
                    Session["admin"] =txtem.Text;
                    Response.Redirect("dashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Invalied Email and Password!!!')</script>");
                }
            }
        }
    }
}