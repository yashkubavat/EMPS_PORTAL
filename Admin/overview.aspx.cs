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
    public partial class overview : System.Web.UI.Page
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
            if (Session["admin"] == null)
            {
                Response.Redirect("index.aspx");
            }
            getcon();
            fillgrd();
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void fillgrd()
        {
            getcon();
            ad = new SqlDataAdapter("select * from emp_tbl e inner join salary_tbl s on e.Id=s.E_Id", con);
            ds = new DataSet();
            ad.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
    }
}