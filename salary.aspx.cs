using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EMPS_PORTAL
{
    public partial class salary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("login.aspx");
            }
            Label1.Text = Session["name"].ToString();
            Label2.Text = Session["name"].ToString();
            Label3.Text = Session["dept"].ToString();
        }
    }
}