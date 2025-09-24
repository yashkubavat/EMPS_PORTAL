using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EMPS_PORTAL.Admin
{
    public partial class salary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("paySalary.aspx");
        }
    }
}