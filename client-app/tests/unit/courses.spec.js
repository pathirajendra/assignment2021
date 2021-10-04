import { shallowMount } from '@vue/test-utils'
import Index from '@/components/Index.vue'

describe('Index.vue', () => {
  it('renders courses list', () => {
    const wrapper = shallowMount(Index, {
      data() {
        return {
          courses: [
            {
              id: 1,
              universityName: 'Stanford University',
              country: 'United States',
              minimum_gpa: 8.5,
              minimum_gre_scroe: 155,
              courseId: 7,
              courseName: 'Chemical Engineering',
              Teacher_name: 'Ronald'
            },
            {
              id: 3,
              universityName: 'University of Wisconsin Madison',
              country: 'United States',
              minimum_gpa: 7.8,
              minimum_gre_scroe: 153,
              courseId: 9,
              courseName: 'Chemical Engineering',
              Teacher_name: 'Stephen'
            }
          ]
        }
      }
    })

    expect(wrapper.vm.courses.length).toBe(2);
  })
})
