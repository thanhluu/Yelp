# Project 2 - *Yelp Lite*

**Yelp Lite** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **2** hours spent in total

## User Stories

The following **required** functionality is completed:

- [ ] Search results page
   - [ ] Table rows should be dynamic height according to the content height.
   - [ ] Custom cells should have the proper Auto Layout constraints.
   - [ ] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [ ] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [ ] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [ ] The filters table should be organized into sections as in the mock.
   - [ ] You can use the default UISwitch for on/off states.
   - [ ] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [ ] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [ ] Implement map view of restaurant results.
- [ ] Filter page
   - [ ] Implement a custom switch instead of the default UISwitch.
   - [ ] Distance filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [ ] Implement the restaurant detail page.

## License

    Copyright 2017 Luu Tien Thanh

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.