import { Component, OnInit, ViewChild } from '@angular/core';
import { DialogService } from '../services/dialog.service';
import {
  FormControl,
  Validators,
  FormGroup,
  FormBuilder,
  AbstractControl,
  ValidationErrors,
  FormGroupDirective
} from '@angular/forms';

@Component({
  selector: 'app-rename-profile-dialog',
  templateUrl: './rename-profile-dialog.component.html',
  styleUrls: ['./rename-profile-dialog.component.scss']
})
export class RenameProfileDialogComponent implements OnInit {
  public oldName: string;

  public formGroup: FormGroup;

  public newName: AbstractControl;

  constructor(private dialog: DialogService, private fb: FormBuilder) {}

  ngOnInit() {
    this.formGroup = this.fb.group({
      newName: ['', [Validators.required, this.notEqualValidator]]
    });
    this.newName = this.formGroup.get('newName');

    this.dialog.dialogReady();
    this.dialog.dialogInput.subscribe(oldName => {
      this.oldName = oldName;
    });
  }

  close() {
    if (this.formGroup.invalid) return;
    this.dialog.closeDialog(this.newName.value);
  }

  private notEqualValidator = (
    control: AbstractControl
  ): ValidationErrors | null => {
    return control.value === this.oldName ? { notEqual: true } : null;
  };
}
