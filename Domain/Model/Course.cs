using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement.Domain.Model;
internal class Course
{
    public int Id { get; set; }
    public string Title { get; set; }
    public int Credits { get; set; }

    public Course(int id, string title, int credits)
    {
        Id = id;
        Title = title;
        Credits = credits;
    }
}
