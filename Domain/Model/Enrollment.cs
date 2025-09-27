using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement.Domain.Model;
internal class Enrollment
{
    public int Id { get; set; }
    public int StudentId { get; set; }
    public int CourseId { get; set; }
    public string Grade { get; set; }

    public Enrollment(int id, int studentId, int courseId, string grade)
    {
        Id = id;
        StudentId = studentId;
        CourseId = courseId;
        Grade = grade;
    }
}
