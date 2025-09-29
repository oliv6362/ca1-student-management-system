using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement.Domain.Model
{
    internal class Department
    {
        public int Id { get; set; }
        public int? DepartmentHeadId { get; set; }
        public string Name { get; set; }
        [Precision(18, 2)]
        public decimal Budget { get; set; }
        public DateTime StartDate { get; set; }
        public Instructor? DepartmentHead { get; set; }
    }
}
