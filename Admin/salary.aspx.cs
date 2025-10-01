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
    public partial class salary : System.Web.UI.Page
    {
        SqlCommand cmd;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter ad;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("index.aspx");
            }
            getcon();
            fillGrid();
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void fillGrid()
        {
            getcon();
            ad = new SqlDataAdapter("select * from salary_tbl",con);
            ds = new DataSet();
            ad.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("paySalary.aspx");
        }
    }
}