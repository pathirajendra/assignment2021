<template>
  <div>
    <h1>Search Universities</h1>

    <div>
      <ul>
        <li v-for="error in errors" :key="error" style="color: red;">{{error}}</li>
      </ul>
    </div>

    <div class="row" style="padding:5px; margin: 10px;">
      <table>
        <tr>
          <td><label>GPA *</label></td>
          <td><input type="number" v-model="gpa" name="gpa"></td>

        </tr>
        <tr>
          <td>
            <label>GRE Score *</label></td>
          <td>
            <input type="number" v-model="greScore">
          </td>

        </tr>
        <tr>
          <td>
            <label>Country *</label></td>
          <td>
            <input type="text" v-model="country"></td>

        </tr>
        <tr>
          <td>
            <label>Course</label></td>
          <td>
            <input type="text" v-model="course"></td>

        </tr>
      </table>
    </div>
    <div>
      <button @click="searchCourse">Search</button>
    </div>




    <div class="table" v-if="courses.length > 0">
      <table border="1" style="margin-top: 20px;">
        <thead>
          <th>Univeristy Name</th>
          <th>Min GPA</th>
          <th>Min GRE Score</th>
          <th>Course</th>
          <th>Teacher Name</th>
        </thead>
        <tbody>
          <tr v-for="course in courses" v-bind:key="course.courseId">
            <td style="padding: 5px;">{{course.universityName}}</td>
            <td>{{course.minimum_gpa}}</td>
            <td>{{course.minimum_gre_scroe}}</td>
            <td>{{course.courseName}}</td>
            <td>{{course.Teacher_name}}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-show="whenNoRecordsFroDB" style="margin-top: 20px;">
      There are no matching results for your search, please change crieteria and try again
    </div>
  </div>
</template>

<script>

  export default {
    name: 'HelloWorld',
    props: {
      msg: String
    },
    data() {
      return {
        courses: [],
        gpa: 6,
        greScore: 140,
        country: 'United States',
        course: null,
        errors: [],
        whenNoRecordsFroDB: false
      }
    },
    methods: {
      searchCourse() {

        this.errors = [];

        if (!this.gpa) {
          this.errors.push('GPA required.');
        }
        if (!this.greScore) {
          this.errors.push('GRE Score required.');
        }
        if (!this.country) {
          this.errors.push('Country required.');
        }


        if (this.errors.length) {
          return true;
        }

        fetch(`http://localhost:1337/searchCourse?gpa=${this.gpa}&greScore=${this.greScore}&country=${this.country}&courseName=${this.course}`)
          .then(response => response.json())
          .then(data => {
            console.log(data)
            this.courses = data;
            if (data.length === 0) {
              this.whenNoRecordsFroDB = true;
            }
            else{
              this.whenNoRecordsFroDB = false;
            }
          });
      },
      isRequired(value) {
        return value ? true : 'This field is required';
      },
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h3 {
    margin: 40px 0 0;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    display: inline-block;
    margin: 0 10px;
  }

  a {
    color: #42b983;
  }

  thead th,
  tbody tr td {
    padding: 5px;
  }
</style>