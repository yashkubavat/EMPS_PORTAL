using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EMPS_PORTAL
{
    public partial class login : System.Web.UI.Page
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
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Login")
            {
                getcon();
                cmd= new SqlCommand("select count(*) from emp_tbl where Email='"+txtun.Text+"' and Password='"+txtpass.Text+"'",con);
                i=Convert.ToInt32(cmd.ExecuteScalar());
                if (i > 0)
                {
                    Session["user"]=txtun.Text;
                    ad = new SqlDataAdapter("select Id,Name,Department from emp_tbl where Email='" + Session["user"] +"'",con);
                    ds=new DataSet();
                    ad.Fill(ds);
                    Session["name"] = ds.Tables[0].Rows[0]["Name"];
                    Session["dept"] = ds.Tables[0].Rows[0]["Department"];
                    Session["eid"] = ds.Tables[0].Rows[0]["Id"];
                    Response.Redirect("employee.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Invalied Email and Password!!!')</script>");
                }
            }
        }
    }
}