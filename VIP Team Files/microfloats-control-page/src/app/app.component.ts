import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators} from '@angular/forms'
import {NgForm} from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'microfloats-control-page'; 

  predeterminedsequence: string = 'nothing here';
  direction: string = 'nothing here';
  duration: string = '0';
  rpm: string = '0';

  ngOnInit() {}

  connectDevice() {
    console.log('Connect MicroFloat bot functionalities here')
  }

  clearManualInput() {
    console.log("Connect Clear Manual Input Functionalities here")
    this.direction = 'nothing here';
    this.duration = '0';
    this.rpm = '0';

  }

  runManualInput(data: any) {
    console.log("Connect Run Manual Input Functionalities here")
    console.warn(data)
  }

  clearPredeterminedSequence() {
    this.predeterminedsequence = 'nothing here';
    console.log(this.predeterminedsequence);
  }

  runPredeterminedSequence(data: any) {
    console.log("Connect Run Predeternined Sequence Functionalities here")
    console.warn(data)
  }


}
